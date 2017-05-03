# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'
require 'base64'

module GoCardlessPro
  # GoCardless API
  class ApiService
    # Initialize an APIService
    #
    # @param url [String] the URL to make requests to
    # @param key [String] the API Key ID to use
    # @param secret [String] the API key secret to use
    # @param options [Hash] additional options to use when creating the service
    def initialize(url, token, options = {})
      @url = url
      root_url, @path_prefix = unpack_url(url)
      http_adapter = options[:http_adapter] || [:net_http]
      connection_options = options[:connection_options]

      @connection = Faraday.new(root_url, connection_options) do |faraday|
        faraday.response :raise_gocardless_errors

        faraday.adapter(*http_adapter)
      end

      @headers = options[:default_headers] || {}
      @headers['Authorization'] = "Bearer #{token}"
    end

    # Make a request to the API
    #
    # @param method [Symbol] the method to use to make the request
    # @param path [String] the URL (without the base domain) to make the request to
    # @param options [Hash] the options hash
    def make_request(method, path, options = {})
      fail ArgumentError, 'options must be a hash' unless options.is_a?(Hash)
      options[:headers] ||= {}
      options[:headers] = @headers.merge(options[:headers])
      Request.new(@connection, method, @path_prefix + path, options).request
    end

    # inspect the API Service
    def inspect
      url = URI.parse(@url)
      url.password = 'REDACTED' unless url.password.nil?
      "#<GoCardlessPro::Client url=\"#{url}\">"
    end
    alias_method :to_s, :inspect

    private

    def unpack_url(url)
      path = URI.parse(url).path
      [URI.join(url).to_s, path == '/' ? '' : path]
    end
  end
end
