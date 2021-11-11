# frozen_string_literal: true

module ActiveCampaign
  class Contact < Model # :nodoc:
    attr_accessor :email, :first_name, :last_name, :phone

    validates :email, :first_name, :last_name, presence: true

    class << self
      def find_by(email:)
        get "#{endpoint}?email=#{email}"
      end
    end

    # @example Create a contact
    #
    #   c = ActiveCampaign::Contact.new first_name: "Fulano", last_name: "Sicrano", email: "foodlover@mail.com"
    #   c.create
    #
    def create
      self.class.post endpoint, {
        contact: {
          email: email,
          firstName: first_name,
          lastName: last_name,
          phone: phone
        }
      }
    end
  end
end
