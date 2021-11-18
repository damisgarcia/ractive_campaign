# frozen_string_literal: true

module ActiveCampaign
  class CustomDealFieldValue < Model # :nodoc:
    define_attributes :dealId,
                      :customFieldId,
                      :fieldValue,
                      :fieldCurrency

    class << self
      def endpoint
        "dealCustomFieldData"
      end

      def root_element
        :dealCustomFieldDatum
      end
    end
  end
end
