# frozen_string_literal: true

module ActiveCampaign
  class Contact < Model # :nodoc:
    attr_accessor :id, :email, :first_name, :last_name, :phone

    validates :email, :first_name, :last_name, presence: true

    class << self
      def find_by(email:)
        r = get "#{endpoint}?email=#{CGI.escape(email)}"
        r = r[:data][:contacts].first

        new(
          id: r[:id],
          email: r[:email],
          first_name: r[:firstName],
          last_name: r[:lastName]
        )
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

    # @example Update a contact
    #
    #   c = ActiveCampaign::Contact.find(1)
    #   c.last_name = "Fulano"
    #   c.save
    #
    def save
      self.class.put "#{endpoint}/#{id}", {
        contact: {
          email: email,
          firstName: first_name,
          lastName: last_name,
          phone: phone
        }
      }
    end

    # @example Delete a contact
    #
    #   ActiveCampaign::Contact.new(id: id).destroy
    #
    def destroy
      self.class.delete "#{endpoint}/#{id}"
    end
  end
end
