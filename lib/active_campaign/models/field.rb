# frozen_string_literal: true

module ActiveCampaign
  class Field < Model # :nodoc:
    define_attributes :type,
                      :title,
                      :descript,
                      :perstag,
                      :defval,
                      :visible,
                      :ordernum
  end
end
