# frozen_string_literal: true

module ActiveCampaign
  class ContactTag < Model # :nodoc:
    define_attributes :contact, :tag

    class << self
      def endpoint
        "contactTags"
      end

      def root_element
        "contactTag"
      end
    end
  end
end
