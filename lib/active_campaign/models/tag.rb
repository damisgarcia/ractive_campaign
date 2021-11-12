# frozen_string_literal: true

module ActiveCampaign
  class Tag < Model # :nodoc:
    attr_accessor :tagType, :tag, :description, :subscriber_count

    class << self
      def find_by(tag:)
        filter({ tags: { tag: tag } }.to_query).last
      end
    end
  end
end
