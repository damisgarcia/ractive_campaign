# frozen_string_literal: true

module ActiveCampaign
  class Contact < Model # :nodoc:
    attr_accessor :email,
                  :phone,
                  :firstName,
                  :lastName,
                  :orgid,
                  :orgname,
                  :segmentio_id,
                  :bounced_hard,
                  :bounced_soft,
                  :bounced_date,
                  :ip,
                  :ua,
                  :hash,
                  :socialdata_lastcheck,
                  :email_local,
                  :email_domain,
                  :sentcnt,
                  :rating_tstamp,
                  :gravatar,
                  :deleted,
                  :anonymized,
                  :adate,
                  :udate,
                  :edate,
                  :deleted_at,
                  :email_empty,
                  :mpp_tracking,
                  :scoreValues,
                  :accountContacts,
                  :organization
  end
end
