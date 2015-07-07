module Alpinist
  class Descriptor
    attr_reader :id, :name, :type, :rt, :href, :doc, :ext
    attr_accessor :reference

    def initialize(id: nil, name: nil, type: nil, rt: nil, href: nil, doc: nil, ext: nil, reference: nil)
      @id = id
      @name = name
      @type = type
      @rt = rt
      @href = href
      @doc = doc
      @ext = ext
      @reference = reference
    end

    def inspect
      display_variable_name = %w(@id @name @type @rt @href @doc @ext)
      variables_inspect = display_variable_name.map{ |n| "#{n}=#{instance_variable_get(n).inspect}" }.join(' ')
      "#<#{self.class}:#{__id__} #{variables_inspect}>"
    end
  end
end
