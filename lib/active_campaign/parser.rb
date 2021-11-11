# frozen_string_literal: true

require "json"

module ActiveCampaign
  class ResponseParser < Faraday::Response::Middleware # :nodoc:
    def on_complete(env)
      parsed_body   = JSON.parse(env[:body], symbolize_names: true)
      metadata      = parsed_body.delete(:meta) || []
      errors        = parsed_body.delete(:errors) || {}
      score_values  = parsed_body.delete(:scoreValues) || {}

      env[:parsed_body] = {
        data: parsed_body,
        errors: errors,
        meta: metadata,
        score_values: score_values
      }
    end
  end
end
