# frozen_string_literal: true

module ActiveCampaign
  class AccountContact < Model # :nodoc:
    define_attributes :contact,
                      :account,
                      :jobTitle
  end
end
