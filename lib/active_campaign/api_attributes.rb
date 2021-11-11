# frozen_string_literal: true

module ActiveCampaign
  module Attributes # :nodoc:
    extend ActiveSupport::Concern

    DEFAULT_ATTRS = %i[
      id
      cdate
      created_timestamp
      updated_timestamp
      created_by
      updated_by
      links
    ].freeze

    class_methods do
      def endpoint
        name.demodulize.underscore.pluralize
      end

      def root_element
        name.demodulize.underscore.to_sym
      end

      def root_elements
        root_element.to_s.pluralize.to_sym
      end

      def set_attributes(attrs, data)
        return new({}) unless data

        new(attrs.map { |attr| [attr, data[attr]] }.to_h)
      end
    end
  end
end
