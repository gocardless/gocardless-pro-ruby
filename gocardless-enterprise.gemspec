# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gocardless/enterprise/version'

Gem::Specification.new do |spec|
  spec.name          = "gocardless-enterprise"
  spec.version       = GoCardless::VERSION
  spec.authors       = %w(GoCardless)
  spec.email         = %w(engineering@gocardless.com)
  spec.description   = %q{THIS API CLIENT IS AUTO-GENERATED. DO NOT MODIFY}
  spec.homepage      = "https://developer.gocardless.com/pro"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'webmock', '~> 1.18'

  spec.add_dependency 'faraday', '>= 0.8.9'
  spec.add_dependency 'activesupport', '~> 4.1'
end
