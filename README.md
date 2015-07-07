# Alpinist

ALPS (Application-Level Profile Semantics) processor

This is currently a work in progress.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alpinist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alpinist

## Usage

See the example below.

## Example

Suppose this ALPS profile were on http://example.com/Rubygem

```json
{
  "alps": {
    "version": "1.0",
    "doc": {
      "format": "text",
      "value": "RubyGem info"
    },
    "descriptor": [
      {
        "id": "RubyGem",
        "type": "semantic",
        "href": "http://alps.io/schema.org/SoftwareApplication#SoftwareApplication",
        "descriptor": [
          {
            "id": "name",
            "type": "semantic",
            "href": "http://alps.io/schema.org/SoftwareApplication#name"
          },
          {
            "id": "version",
            "type": "semantic",
            "href": "http://alps.io/schema.org/SoftwareApplication#version"
          },
          {
            "id": "authors",
            "type": "semantic",
            "href": "http://alps.io/schema.org/SoftwareApplication#author"
          },
          {
            "id": "info",
            "type": "semantic",
            "href": "http://alps.io/schema.org/SoftwareApplication#description"
          },
          {
            "id": "licenses",
            "type": "semantic",
            "href": "http://alps.io/schema.org/SoftwareApplication#license"
          },
          {
            "id": "project_uri",
            "type": "safe",
            "href": "http://alps.io/schema.org/SoftwareApplication#url"
          },
          {
            "id": "gem_uri",
            "type": "safe",
            "href": "http://alps.io/schema.org/SoftwareApplication#downloadUrl"
          },
          {
            "id": "homepage_uri",
            "type": "safe",
            "href": "http://alps.io/iana/relations#related"
          },
          {
            "id": "source_code_uri",
            "type": "safe"
          },
          {
            "id": "dependencies",
            "type": "semantic",
            "href": "http://alps.io/schema.org/SoftwareApplication#requirements"
          }
        ]
      }
    ]
  }
}
```

```ruby
fetcher = Alpinist::ProfileFetcher.new
profile_url = 'http://example.com/Rubygem'
doc = fetcher.fetch(profile_url)
profile = Alpinist::Profile.new(doc, profile_url)
semantics = Alpinist::Semantics.new(profile, fetcher)
semantics.build!
semantics.print_tree # for debug
```
```
* http://alps.io/schema.org/Thing
+---+ http://alps.io/schema.org/CreativeWork
    +---+ http://alps.io/schema.org/SoftwareApplication#SoftwareApplication
        +---> http://example.com/RubyGem#RubyGem
* http://alps.io/schema.org/Thing#name
+---+ http://alps.io/schema.org/SoftwareApplication#name
    +---> http://example.com/RubyGem#name
* http://alps.io/schema.org/CreativeWork#version
+---+ http://alps.io/schema.org/SoftwareApplication#version
    +---> http://example.com/RubyGem#version
* http://alps.io/schema.org/CreativeWork#author
+---+ http://alps.io/schema.org/SoftwareApplication#author
    +---> http://example.com/RubyGem#authors
* http://alps.io/schema.org/Thing#description
+---+ http://alps.io/schema.org/SoftwareApplication#description
    +---> http://example.com/RubyGem#info
* http://example.com/RubyGem#licenses
* http://alps.io/schema.org/Thing#url
+---+ http://alps.io/schema.org/SoftwareApplication#url
    +---> http://example.com/RubyGem#project_uri
* http://alps.io/schema.org/SoftwareApplication#downloadUrl
+---> http://example.com/RubyGem#gem_uri
* http://alps.io/iana/relations#related
+---> http://example.com/RubyGem#homepage_uri
* http://example.com/RubyGem#source_code_uri
* http://alps.io/schema.org/SoftwareApplication#requirements
+---> http://example.com/RubyGem#dependencies
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/alpinist/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
