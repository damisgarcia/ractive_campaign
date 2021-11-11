# frozen_string_literal: true

module ActiveCampaign
  class Tag < Model # :nodoc:
    ATTRS = (%i[
      tagType
      tag
      description
      subscriber_count
    ] + DEFAULT_ATTRS).freeze

    attr_accessor(*ATTRS)

    class << self
      def find_by(tag:)
        # result = get "#{endpoint}?tags[tag]=#{tag}"
        result = find({ tags: { tag: tag } }.to_query)

        data = result[:data][root_elements]
        data = data.is_a?(Array) ? data.first : data

        set_attributes ATTRS, data
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
