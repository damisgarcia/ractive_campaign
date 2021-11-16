# frozen_string_literal: true

module ActiveCampaign
  class Model # :nodoc:
    include ActiveModel::Model
    include ActiveModel::Dirty

    include ActiveCampaign::ApiHttp
    include ActiveCampaign::Attributes

    class << self
      def all
        get endpoint
      end

      def filter(args = {})
        get "#{endpoint}?#{args}"
      end

      def find_by(args = {})
        filter(args.to_query).last
      end

      def find(id)
        get "#{endpoint}/#{id}"
      end

      def save(**args)
        new(args).save
      end

      def create(**args)
        new(args).create
      end
    end

    def save
      return update if defined?(id) && id.present?

      create
    end

    def update
      return nil unless changed?

      result = self.class.put "#{self.class.endpoint}/#{id}", only_changes_to_params

      changes_applied

      result
    end

    def create
      result = self.class.post self.class.endpoint, to_params

      changes_applied

      result
    end

    def destroy
      self.class.delete "#{self.class.endpoint}/#{id}"
    end
  end
end
