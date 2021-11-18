# frozen_string_literal: true

module ActiveCampaign
  class Stage < Model # :nodoc:
    define_attributes :cardRegion1,
                      :cardRegion2,
                      :cardRegion3,
                      :cardRegion4,
                      :cardRegion5,
                      :color,
                      :dealOrder,
                      :group,
                      :order,
                      :title,
                      :width
    class << self
      def endpoint
        "dealStages"
      end
    end
  end
end
