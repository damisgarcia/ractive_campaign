# frozen_string_literal: true

module ActiveCampaign
  class Tag < Model # :nodoc:
    ATTRS = %i[
      id
      tagType
      tag
      description
      subscriber_count
      cdate
      created_timestamp
      updated_timestamp
      created_by
      updated_by
      links
    ].freeze

    attr_accessor(*ATTRS)

    class << self
      def all
        get endpoint
      end

      def find_by(name:)
        result = get "#{endpoint}?tags[tag]=#{name}"

        data = result[:data][root_elements]
        data = data.is_a?(Array) ? data.first : data

        set_attributes ATTRS, data
      end

      def find(id)
        get "#{endpoint}/#{id}"
      end
    end

    def create
      result = self.class.post endpoint, {
        tag: {
          tag: tag,
          tagType: tagType,
          description: description
        }
      }

      data = result[:data][self.class.root_element]
      data = data.is_a?(Array) ? data.first : data

      self.class.set_attributes ATTRS, data
    end

    def update
      result = self.class.put "#{endpoint}/#{id}", {
        tag: {
          tag: tag,
          tagType: tagType,
          description: description
        }
      }

      data = result[:data][self.class.root_element]
      data = data.is_a?(Array) ? data.first : data

      self.class.set_attributes ATTRS, data
    end
    alias save update

    def destroy
      self.class.delete "#{endpoint}/#{id}"
    end
  end
end
