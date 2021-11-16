# frozen_string_literal: true

module ActiveCampaign
  class Contact < Model # :nodoc:
    define_attributes :email,
                      :phone,
                      :firstName,
                      :lastName
  end
end
