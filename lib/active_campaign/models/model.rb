# frozen_string_literal: true

require "active_support/concern"

module ActiveCampaign
  class Model # :nodoc:
    include ActiveModel::Model
    include ActiveCampaign::ApiHttp

    extend ActiveSupport::Concern

    class << self
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

      def create(**args)
        new(args).create
      end
    end

    def endpoint
      self.class.endpoint
    end
  end
end
