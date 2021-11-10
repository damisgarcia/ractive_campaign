# frozen_string_literal: true

module ActiveCampaign
  class Error < RuntimeError # :nodoc:
    def initialize(response = nil, exception = nil)
      super

      self.response = response
      @exception = exception
    end

    def message
      if response.nil?
        super
      else
        <<~MESSAGE
          STATUS: #{response.status}
          URL: #{env.url}
          REQUEST HEADERS: #{env.request_headers}
          RESPONSE_HEADERS: #{env.response_headers}
          REQUEST_BODY: #{env.request_body}\n\n"
          RESPONSE_BODY: #{response.body}\n\n"
        MESSAGE
      end
    end

    private

    def env
      @env ||= response.env
    end

    attr_accessor :response
  end

  class ClientError < Error
  end

  class UnauthorizedError < ClientError
  end

  class ResourceNotFound < ClientError
  end

  class UnprocessableEntityError < ClientError
  end
end
