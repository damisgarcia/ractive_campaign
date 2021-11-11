# frozen_string_literal: true

module ActiveCampaign
  module ApiHttp # :nodoc:
    extend ActiveSupport::Concern

    HTTP_METHODS = %i[get post put delete].freeze

    module ClassMethods # :nodoc:
      def request(params = {})
        conn = ActiveCampaign::API.setup
        request = conn.request(params)

        if block_given?
          yield request[:parsed_body], request[:_response]
        else
          request
        end
      end

      HTTP_METHODS.each do |method|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{method}(path, params={})
            send(:'#{method}_raw', path, params) do |body, response|
              body
            end
          end

          def #{method}_raw(path, params={}, &block)
            request(params.merge(:_method => #{method.to_sym.inspect}, :_path => path), &block)
          end
        RUBY
      end
    end
  end
end
