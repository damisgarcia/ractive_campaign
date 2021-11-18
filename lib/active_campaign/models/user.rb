# frozen_string_literal: true

module ActiveCampaign
  class User < Model # :nodoc:
    class << self
      def find_by_email(email)
        get "#{endpoint}/email/#{email}"
      end

      def find_by_username(username)
        get "#{endpoint}/username/#{username}"
      end
    end
  end
end
