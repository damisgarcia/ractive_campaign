# frozen_string_literal: true

module ActiveCampaign
  class Model # :nodoc:
    include ActiveModel::Model
    include ActiveCampaign::Attributes
    include ActiveCampaign::ApiHttp

    class << self
      def all
        get endpoint
      end

      def find(args = {})
        get "#{endpoint}?#{args}"
      end

      def create(**args)
        new(args).create
      end
    end
  end
end
