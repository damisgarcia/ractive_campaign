# frozen_string_literal: true

module ActiveCampaign
  class TaskType < Model # :nodoc:
    define_attributes :title, :status

    class << self
      def endpoint
        "dealTasktypes"
      end
    end
  end
end
