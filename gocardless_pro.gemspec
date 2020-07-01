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

  spec.add_dependency 'faraday', ['>= 0.9.2', '< 2']

  spec.add_development_dependency 'rspec', '~> 3.7.0'
  spec.add_development_dependency 'webmock', '~> 3.8.3'
  spec.add_development_dependency 'rubocop', '~> 0.49.1'
  spec.add_development_dependency 'yard', '~> 0.9.11'

  # Pin the version of the 'public_suffix' gem, which is a transitive dependency
  # of 'webmock' (newer versions require Ruby 2.1+).
  spec.add_development_dependency 'public_suffix', '~> 2.0.5'

  # Pin the version of the 'parallel' gem, which is a transitive dependency of
  # 'rubocop' (newer versions require Ruby 2.2+).
  spec.add_development_dependency 'parallel', '~> 1.13.0'

  # Pin the version of the 'rake' gem, which is a transitive dependency of
  # 'rainbow' (newer versions require Ruby 2.2+).
  spec.add_development_dependency 'rake', '< 14'
end
