# frozen_string_literal: true

module ActiveCampaign
  class Model # :nodoc:
    include ActiveModel::Model
    extend ApiConnection

    class << self
      def create(**args)
        new(args).create
      end
    end
  end
end
