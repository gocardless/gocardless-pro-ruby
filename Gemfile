source 'https://rubygems.org'
gemspec

# We support both pre-1.x and post-1.x Faraday versions, but to ensure compatibility we
# pin this gem against each in separate runs of CI, using the FARADAY_VERSION env var. For
# more details on the values, see .github/workflows/tests.yml in the gocardless-pro-ruby
# repository.
if ENV.key?("FARADAY_VERSION")
  gem 'faraday', "~> #{ENV["FARADAY_VERSION"]}"
end
