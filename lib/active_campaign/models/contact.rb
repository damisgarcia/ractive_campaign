# frozen_string_literal: true

module ActiveCampaign
  #
  # @example Contacts
  #
  #   ActiveCampaign::Contact.find(1)
  #   ActiveCampaign::Contact.find_by email: "contact-1@mail.com"
  #   ActiveCampaign::Contact.find(1).destroy
  #   ActiveCampaign::Contact.find(1).contact_tags
  #
  class Contact < Model
    define_attributes :email,
                      :phone,
                      :firstName,
                      :lastName

    # @example Find contact's tags.
    #
    #   ActiveCampaign::Contact.find(1).contact_tags
    #   ActiveCampaign::Contact.find(1).contact_tags.last.destroy
    #
    def contact_tags
      ContactTag.get "#{self.class.endpoint}/#{id}/contactTags"
    end

    # @example Apply a tag to a contact.
    #
    #   ActiveCampaign::Contact.find(1).apply_tag "tag-name"
    #
    def apply_tag(tag)
      tag_id = Tag.find_by(tag: tag)&.id

      ActiveCampaign::ContactTag.create contact: id, tag: tag_id if tag_id
    end
  end
end
