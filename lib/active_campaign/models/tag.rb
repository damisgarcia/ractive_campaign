# frozen_string_literal: true

module ActiveCampaign
  class Tag < Model # :nodoc:
    define_attributes :tagType, :tag, :description, :subscriber_count

    class << self
      def find_by(tag:)
        filter({ tags: { tag: tag } }.to_query).last
      end
    end
  end
end
