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
        name.demodulize.underscore
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
