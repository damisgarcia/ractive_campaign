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
        filter({ tags: { tag: tag } }.to_query).last
      end
    end

    # TODO:
    def to_params
      {
        tag: {
          tag: tag,
          tagType: tagType,
          description: description
        }
      }
    end
  end
end
