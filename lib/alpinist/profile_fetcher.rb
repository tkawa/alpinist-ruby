require 'open-uri'
module Alpinist
  class ProfileFetcher
    def fetch(url, as: nil, &block)
      if url.match(%r|http://alps\.io/|)
        as ||= url
        url = "#{url}.xml"
      end
      if as
        puts "Fetch: #{url} as #{as}"
      else
        puts "Fetch: #{url}"
      end
      block ||= ->(sio) { sio.read }
      open(url, &block)
    end
  end
end
