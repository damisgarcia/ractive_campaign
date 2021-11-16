# frozen_string_literal: true

module ActiveCampaign
  module ApiHttp # :nodoc:
    extend ActiveSupport::Concern

    HTTP_METHODS = %i[get post put delete].freeze

    module ClassMethods # :nodoc:
      HTTP_METHODS.each do |method|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{method}(path, params={})
            root = params.delete(:_root)

            send(:'#{method}_raw', path, params) do |parsed_data, response|
              return {} unless [200, 201].include?(parsed_data[:status_code])
              return {} unless parsed_data[:data].present?

              data = if root
                parsed_data[:data][root.to_sym]
              else
                parsed_data[:data].first.last
              end

              if data.is_a?(Array)
                new_records data
              else
                new_record data
              end
            end
          end

          def #{method}_raw(path, params={}, &block)
            request(params.merge(:_method => #{method.to_sym.inspect}, :_path => path), &block)
          end
        RUBY
      end

      def request(params = {})
        api = ActiveCampaign::API.new
        request = api.request params

        if block_given?
          yield request[:parsed_data], request[:_response]
        else
          request
        end
      end
    end
  end
end
