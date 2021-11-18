# frozen_string_literal: true

module ActiveCampaign
  class Deal < Model # :nodoc:
    define_attributes :contact,
                      :account,
                      :description,
                      :currency,
                      :group,
                      :owner,
                      :percent,
                      :stage,
                      :status,
                      :title,
                      :value
  end
end
