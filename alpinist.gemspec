# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alpinist/version'

Gem::Specification.new do |spec|
  spec.name          = "alpinist"
  spec.version       = Alpinist::VERSION
  spec.authors       = ["Toru KAWAMURA"]
  spec.email         = ["tkawa@4bit.net"]

  spec.summary       = %q{ALPS (Application-Level Profile Semantics) processor}
  spec.description   = %q{ALPS (Application-Level Profile Semantics) processor}
  spec.homepage      = "https://github.com/tkawa/alpinist-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "multi_xml"
  spec.add_dependency "rubytree"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
