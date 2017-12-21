# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gocardless_pro/version'

Gem::Specification.new do |spec|
  spec.name          = 'gocardless_pro'
  spec.version       = GoCardlessPro::VERSION
  spec.authors       = %w(GoCardless)
  spec.email         = %w(engineering@gocardless.com)
  spec.summary       = %q{A gem for calling the GoCardless Pro API}
  spec.homepage      = 'https://github.com/gocardless/gocardless-pro-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec', '~> 3.7.0'
  spec.add_development_dependency 'webmock', '~> 1.18'
  spec.add_development_dependency 'rubocop', '~> 0.49.1'
  spec.add_development_dependency 'yard', '~> 0.9.11'

  spec.add_dependency 'faraday', ['>= 0.9.2', '< 1.0']
end
