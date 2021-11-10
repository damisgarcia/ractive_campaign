# frozen_string_literal: true

require "dry-configurable"
require "faraday"

require_relative "active_campaign/version"

module ActiveCampaign # :nodoc:
  extend Dry::Configurable

  class Error < StandardError; end

  RESOURCE_MODELS = Dir[File.expand_path("active_campaign/models/**/*.rb", File.dirname(__FILE__))].freeze

  RESOURCE_MODELS.each do |f|
    autoload File.basename(f, ".rb").camelcase.to_sym, f
  end

  setting :api_url
  setting :api_key
end
