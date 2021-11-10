# frozen_string_literal: true

module ActiveCampaign
  module ApiConnection # :nodoc:
    def connection
      @connection ||= Faraday.new(::ActiveCampaign.config.api_url) do |f|
        f.request :json

        f.response :json, content_type: "application/json"
        f.response :logger
        f.response :raise_error

        f.adapter Faraday.default_adapter
      end

      @connection.headers["Api-Token"] = ::ActiveCampaign.config.api_key
      @connection
    end

    def get(*args)
      safe_call do
        connection.get(*args)
      end
    end

    def post(*args)
      safe_call do
        connection.post(*args)
      end
    end

    def put(*args)
      safe_call do
        connection.put(*args)
      end
    end

    def delete(*args)
      safe_call do
        connection.delete(*args)
      end
    end

    private

    def safe_call
      response = yield
      response.body
    rescue ::Faraday::UnprocessableEntityError => e
      raise ::ActiveCampaign::UnprocessableEntityError, e
    rescue ::Faraday::ResourceNotFound => e
      raise ::ActiveCampaign::ResourceNotFound, e
    rescue RuntimeError => e
      raise ::ActiveCampaign::ClientError, e
    end
  end
end
