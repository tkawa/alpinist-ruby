require 'json'
require 'multi_xml'

module Alpinist
  class Profile
    attr_reader :root_nodes, :url

    def initialize(document, url)
      @document = document
      @url = url
      @root_nodes = []
      @descriptors = {}
      @insubstantial_descriptors = []
      parse!
    end

    def find_node(id)
      @root_nodes.inject(nil) do |result, root_node|
        result || root_node.find { |node| node.name == id && node.content.reference.nil? }
      end
    end

    def find_descriptor(id)
      id = id.sub(/^#/, '')
      @descriptors[id] || @insubstantial_descriptors.find { |descriptor| descriptor.id == id }
    end

    def root_descriptors
      @root_nodes.map(&:content)
    end

    def all_descriptors
      @descriptors.values
    end

    private

    def parse!
      doc =
        begin
          JSON.parse(@document)
        rescue JSON::ParserError # TODO: improve
          MultiXml.parse(@document)
        end
      alps = doc['alps']
      raise unless alps

      @root_nodes = Array.wrap(alps['descriptor']).map do |data|
        define_descriptor(data)
      end
    end

    def define_descriptor(data)
      if data['id'] # substantial
        id = data['id']
        descriptor = Descriptor.new(id: id, name: data['name'], type: data['type'], rt: data['rt'], href: data['href'], doc: data['doc'], ext: data['ext'])
        @descriptors[id] = descriptor
        set_reference(id, descriptor)
      else # insubstantial
        url, id = data['href'].split('#')
        reference = @descriptors[id] if url.empty?
        descriptor = Descriptor.new(id: id, name: data['name'], type: data['type'], rt: data['rt'], href: data['href'], doc: data['doc'], ext: data['ext'], reference: reference)
        @insubstantial_descriptors << descriptor
      end
      node = Tree::TreeNode.new(id, descriptor) # 適切なTreeに取替可能
      if data['descriptor']
        Array.wrap(data['descriptor']).each do |data_child|
          node << define_descriptor(data_child) # FIXME: idの重複
        end
      end
      node
    end

    def set_reference(id, descriptor) # 必要？
      @insubstantial_descriptors.each do |insubstantial_descriptor|
        if insubstantial_descriptor.reference.nil? && insubstantial_descriptor.id == id
          insubstantial_descriptor.reference = descriptor
        end
      end
    end
  end
end
