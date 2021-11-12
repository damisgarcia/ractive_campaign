# frozen_string_literal: true

require "json"

module ActiveCampaign
  class ResponseParser < Faraday::Response::Middleware # :nodoc:
    def on_complete(env)
      parsed_data   = JSON.parse(env[:body], symbolize_names: true)
      metadata      = parsed_data.delete(:meta) || []
      errors        = parsed_data.delete(:errors) || {}
      score_values  = parsed_data.delete(:scoreValues) || {}
      status_code   = env[:status]

      env[:parsed_data] = {
        status_code: status_code,
        data: parsed_data,
        errors: errors,
        meta: metadata,
        score_values: score_values
      }
    end
  end
end
