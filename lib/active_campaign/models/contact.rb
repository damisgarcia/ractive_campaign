# frozen_string_literal: true

module ActiveCampaign
  class Contact < Model # :nodoc:
    attr_accessor :email, :first_name, :last_name, :phone

    validates :email, :first_name, :last_name, presence: true

    class << self
      def find_by(email:)
        get "contacts?email=#{email}"
      end
    end

    # @example Create a contact
    #
    #   ActiveCampaign::Contact.create first_name: "Fulano", last_name: "Sicrano", email: "foodlover@mail.com"
    #
    def create
      self.class.post "contacts", {
        contact: {
          email: email,
          firstName: first_name,
          lastName: last_name,
          phone: phone
        }
      }.stringify_keys
    end
  end
end
