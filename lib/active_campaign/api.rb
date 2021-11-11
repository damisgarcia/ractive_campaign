# frozen_string_literal: true

module ActiveCampaign
  class API # :nodoc:
    attr_reader :connection

    def initialize(*args, &blk)
      setup(*args, &blk)
    end

    def self.setup(opts = {}, &block)
      @api = new(opts, &block)
    end

    def setup(opts={})
      @connection = Faraday.new(::ActiveCampaign.config.api_url) do |f|
        f.request :json
        f.response :json, content_type: "application/json"

        f.use ::ActiveCampaign::ResponseParser
        f.use Faraday::Request::UrlEncoded

        f.adapter Faraday.default_adapter
      end

      @connection.headers["Api-Token"] = ::ActiveCampaign.config.api_key

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

      { parsed_body: response.env[:parsed_body], _response: response }
    end
  end
end
