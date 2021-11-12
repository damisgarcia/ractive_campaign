# frozen_string_literal: true

module ActiveCampaign
  class API # :nodoc:
    attr_reader :connection

    def initialize
      setup
    end

    def setup
      @connection = Faraday.new(::ActiveCampaign.config.api_url) do |f|
        f.request :json
        f.response :json, content_type: "application/json"

        f.use ::ActiveCampaign::ResponseParser
        f.use Faraday::Request::UrlEncoded

        f.adapter Faraday.default_adapter
      end

      @connection.headers["Api-Token"] = ::ActiveCampaign.config.api_key
      @connection.headers["User-Agent"] = "Ruby ActiveCampaign (ractive_campaign)"

      self
    end

    # @private
    def request(opts = {})
      method  = opts.delete(:_method)
      path    = opts.delete(:_path)
      headers = opts.delete(:_headers)

      opts.delete_if { |key, _| key.to_s =~ /^_/ } # Remove all internal parameters

      response = @connection.send method do |request|
        request.headers.merge!(headers) if headers

        if method == :get
          request.url path, opts
        else
          request.url path
          request.body = opts
        end
      end

      {
        parsed_data: response.env[:parsed_data],
        _response: response
      }
    end
  end
end
