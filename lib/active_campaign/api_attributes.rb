# frozen_string_literal: true

module ActiveCampaign
  module Attributes # :nodoc:
    extend ActiveSupport::Concern

    attr_accessor :all_attrs

    DEFAULT_ATTRS = %i[
      id
      cdate
      created_timestamp
      updated_timestamp
      created_utc_timestamp
      updated_utc_timestamp
      created_by
      updated_by
      links
    ].freeze

    def only_changes_to_params
      return nil unless changed?

      root, root_params = to_params.first

      {
        root => root_params.slice(*changed)
      }
    end

    def to_params
      iv = instance_variables - DEFAULT_ATTRS.map { |da| :"@#{da}" } - %i[@mutations_from_database @mutations_before_last_save]

      {
        self.class.root_element => iv.map { |v| [v.to_s.delete("@"), instance_variable_get(v)] }.to_h
      }
    end

    module ClassMethods # :nodoc:
      def define_attributes(*attrs)
        attrs.each do |attr|
          define_attribute_methods attr

          class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def #{attr}
              @#{attr}
            end

            def #{attr}=(val)
              #{attr}_will_change! unless val == @#{attr}
              @#{attr} = val
            end
          RUBY
        end
      end

      def new_records(data)
        instantiate_records self, data
      end

      def new_record(data)
        instantiate_record self, data
      end

      def instantiate_record(klass, data)
        record = klass.new data
        record.clear_changes_information
        record
      end

      def instantiate_records(klass, records_data)
        records_data.map do |record_data|
          instantiate_record klass, record_data
        end
      end

      def endpoint
        name.demodulize.underscore.pluralize
      end

      def root_element
        name.demodulize.underscore.to_sym
      end

      def root_elements
        root_element.to_s.pluralize.to_sym
      end
    end

    # def reload!
    #   # get the values from the persistence layer
    #   clear_changes_information
    # end

    def rollback!
      restore_attributes
    end
  end
end
