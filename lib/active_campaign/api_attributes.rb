# frozen_string_literal: true

module ActiveCampaign
  module Attributes # :nodoc:
    extend ActiveSupport::Concern

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
      _meta
      _errors
    ].freeze

    attr_accessor(*DEFAULT_ATTRS)

    def to_params
      {
        self.class.root_element => instance_variables.map { |v| [v.to_s.delete("@"), instance_variable_get(v)] }.to_h
      }
    end

    module ClassMethods # :nodoc:
      def new_records(data)
        instantiate_records self, data
      end

      def new_record(data)
        instantiate_record self, data
      end

      def instantiate_record(klass, data)
        klass.new data
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
  end
end
