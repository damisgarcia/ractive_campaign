# frozen_string_literal: true

module ActiveCampaign
  #
  # @example ContactTags
  #
  #   contact = ActiveCampaign::Contact.find(1)
  #   tag = ActiveCampaign::Tag.find(1)
  #
  #   ActiveCampaing::ContactTag.create contact: contact, tag: tag
  #
  class ContactTag < Model
    define_attributes :contact, :tag

    def create
      self.tag = extract_id_from_tag(tag)
      self.contact = extract_id_from_contact(contact)

      super
    end

    private

    def extract_id_from_tag(tag)
      case tag
      when ::ActiveCampaign::Tag then tag.id
      else
        tag
      end
    end

    def extract_id_from_contact(contact)
      case contact
      when ::ActiveCampaign::Contact then contact.id
      else
        contact
      end
    end
  end
end
