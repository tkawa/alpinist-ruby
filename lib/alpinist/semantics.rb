module Alpinist
  class Semantics
    def initialize(initial_profile, fetcher = ProfileFetcher.new)
      @initial_profile = initial_profile
      @fetcher = fetcher
      @profiles = {}
      @profiles[initial_profile.url] = initial_profile
      @nodes = {}
    end

    def build!
      @initial_profile.all_descriptors.each do |descriptor|
        descriptor_url = "#{@initial_profile.url}##{descriptor.id}"
        connect_to_parent(descriptor_url, descriptor)
      end
    end

    def find_node(descriptor_url)
      @nodes[descriptor_url]
    end

    def print_tree
      root_nodes = @nodes.values.select { |node| node.is_root? }
      root_nodes.each(&:print_tree)
    end

    private

    def connect_to_parent(descriptor_url, descriptor)
      node = (@nodes[descriptor_url] ||= Tree::TreeNode.new(descriptor_url, descriptor)) # 適切なTreeに取替可能
      if parent_descriptor_url = descriptor.href
        parent_descriptor = find_descriptor(parent_descriptor_url)
        if parent_descriptor
          parent_node = connect_to_parent(parent_descriptor_url, parent_descriptor)
          parent_node << node
        else
          puts "Descriptor #{parent_descriptor_url} not found."
        end
      end
      node
    end

    def find_descriptor(descriptor_url)
      profile_url, descriptor_id = descriptor_url.split('#')
      profile = (@profiles[profile_url] ||= begin
        document = @fetcher.fetch(profile_url)
        Profile.new(document, profile_url)
      end)
      if descriptor_id
        profile.find_descriptor(descriptor_id)
      else
        profile.root_descriptors.first # idなしの参照は先頭のdescriptorを指すことにする
      end
    end
  end
end
