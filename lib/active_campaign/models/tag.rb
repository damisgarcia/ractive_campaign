# frozen_string_literal: true

module ActiveCampaign
  class Tag < Model # :nodoc:
    define_attributes :tag, :tagType, :description
  end
end
