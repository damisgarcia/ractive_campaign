# frozen_string_literal: true

module ActiveCampaign
  module Attributes # :nodoc:
    extend ActiveSupport::Concern

    def only_changes_to_params
      return nil unless changed?

      root, root_params = to_params.first

      {
        root => root_params.slice(*changed)
      }
    end

    def to_params
      iv = instance_variables - %i[@mutations_from_database @mutations_before_last_save]

      {
        self.class.root_element => iv.map { |v| [v.to_s.delete("@"), instance_variable_get(v)] }.to_h
      }
    end

    module ClassMethods # :nodoc:
      def define_attributes(*attrs)
        attrs.each do |attr|
          # ActiveModel's define_attribute_methods
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
        define_attributes(*data.keys)

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
        name.demodulize.camelize(:lower).pluralize
      end

      def root_element
        name.demodulize.camelize(:lower).to_sym
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
