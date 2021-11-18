# frozen_string_literal: true

module ActiveCampaign
  class Task < Model # :nodoc:
    define_attributes :title,
                      :ownerType,
                      :relid,
                      :status,
                      :note,
                      :duedate,
                      :edate,
                      :dealTasktype,
                      :assignee,
                      :triggerAutomationOnCreate,
                      :doneAutomation

    class << self
      def endpoint
        "dealTasks"
      end
    end
  end
end
