# frozen_string_literal: true

module ActiveCampaign
  class Tag < Model # :nodoc:
    define_attributes :tag, :tagType, :description

    def create
      self.tagType ||= "contact"

      super
    end
  end
end
