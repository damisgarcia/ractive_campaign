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
        query = args.map { |k, v| "filters[#{k}]=#{v}" }.join "&"

        get "#{endpoint}?#{query}"
      end

      def find_by(args = {})
        filter(args).last
      end

      def find(id)
        get "#{endpoint}/#{id}", { _root: root_element }
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

      assign_attributes result.to_params.first.last

      changes_applied

      self
    end

    def create
      result = self.class.post self.class.endpoint, to_params

      assign_attributes result.to_params.first.last

      changes_applied

      self
    end

    def destroy
      self.class.delete "#{self.class.endpoint}/#{id}"
    end
  end
end
