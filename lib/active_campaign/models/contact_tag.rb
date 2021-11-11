# frozen_string_literal: true

module ActiveCampaign
  class ContactTag < Model # :nodoc:
    def create
      self.class.post endpoint, {
        contactTag: {
          contact: contact_id,
          tag: tag_id
        }
      }
    end

    def destroy
      self.class.delete "#{endpoint}/#{id}"
    end
  end
end
