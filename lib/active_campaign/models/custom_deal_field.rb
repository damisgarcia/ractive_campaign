# frozen_string_literal: true

module ActiveCampaign
  class CustomDealField < Model # :nodoc:
    define_attributes :fieldLabel,
                      :fieldType,
                      :fieldDefault,
                      :isFormVisible,
                      :displayOrder

    class << self
      def endpoint
        "dealCustomFieldMeta"
      end

      def root_element
        :dealCustomFieldMetum
      end
    end
  end
end
