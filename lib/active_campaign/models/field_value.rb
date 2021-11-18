# frozen_string_literal: true

module ActiveCampaign
  class FieldValue < Model # :nodoc:
    define_attributes :contact,
                      :field,
                      :value
  end
end
