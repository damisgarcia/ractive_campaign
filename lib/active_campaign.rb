# frozen_string_literal: true

require "dry-configurable"

require "faraday"
require "faraday_middleware"

require "active_model"
# require "active_support"
require "active_support/inflector"

require "active_campaign/version"
require "active_campaign/parser"
require "active_campaign/api_attributes"
require "active_campaign/api_errors"
require "active_campaign/api"
require "active_campaign/api_http"

module ActiveCampaign # :nodoc:
  extend Dry::Configurable

  RESOURCE_MODELS = Dir[File.expand_path("active_campaign/models/**/*.rb", File.dirname(__FILE__))].freeze

  RESOURCE_MODELS.each do |f|
    autoload File.basename(f, ".rb").camelcase.to_sym, f
  end

  setting :api_url
  setting :api_key
end
