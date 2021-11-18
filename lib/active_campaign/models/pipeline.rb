# frozen_string_literal: true

module ActiveCampaign
  class Pipeline < Model # :nodoc:
    define_attributes :allgroups,
                      :allusers,
                      :autoassign,
                      :currency,
                      :title,
                      :users

    class << self
      def endpoint
        "dealGroups"
      end
    end
  end
end
