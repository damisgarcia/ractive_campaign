# frozen_string_literal: true

module ActiveCampaign
  class List < Model # :nodoc:
    define_attributes :name,
                      :stringid,
                      :sender_url,
                      :sender_reminder,
                      :user
  end
end
