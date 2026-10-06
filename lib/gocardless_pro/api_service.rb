#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'
require 'base64'

module GoCardlessPro
  # GoCardless API
  class ApiService
    attr_reader :on_idempotency_conflict

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
      connection_options = options.fetch(:connection_options, {})

      @connection = Faraday.new(root_url, connection_options) do |faraday|
        faraday.response :raise_gocardless_errors

        faraday.adapter(*http_adapter)
      end

      @headers = options[:default_headers] || {}
      @headers['Authorization'] = "Bearer #{token}"
      @on_idempotency_conflict = options[:on_idempotency_conflict] || :fetch

      return if %i[fetch raise].include?(@on_idempotency_conflict)

      raise ArgumentError, 'Unknown mode for :on_idempotency_conflict'
    end

    # Make a request to the API
    #
    # @param method [Symbol] the method to use to make the request
    # @param path [String] the URL (without the base domain) to make the request to
    # @param options [Hash] the options hash
    def make_request(method, path, options = {})
      raise ArgumentError, 'options must be a hash' unless options.is_a?(Hash)

      options[:headers] ||= {}
      options[:headers] = @headers.merge(options[:headers])
      Request.new(@connection, method, @path_prefix + validate_path(path), options).request
    end

    # inspect the API Service
    def inspect
      url = URI.parse(@url)
      url.password = 'REDACTED' unless url.password.nil?
      "#<GoCardlessPro::Client url=\"#{url}\">"
    end
    alias to_s inspect

    private

    # Check that a request path cannot move the request off the configured API URL.
    #
    # `path` is documented as a URL without the base domain, but Faraday resolves it against
    # the connection's prefix the way a browser resolves a link: an absolute URL
    # ('https://host/x') or a scheme-relative one ('//host/x') replaces the configured origin
    # outright, while the Authorization header is still attached. A caller that passes
    # untrusted input as `path` would therefore hand the token to a host of someone else's
    # choosing, so anything that is not a relative reference is rejected before it is joined.
    #
    # Parsing with URI.parse is what Faraday's own merge does, so a value cannot be read as
    # relative here and as absolute there. URI.parse is strict and raises on values a looser
    # parser might read as a host, so a parse failure is rejected for the same reason.
    #
    # Dot segments are left alone: they resolve against the base URL and so cannot leave the
    # configured origin, which is the property this guards.
    #
    # @param path [String] the path to validate
    def validate_path(path)
      parsed = begin
        URI.parse(path.to_s)
      rescue URI::InvalidURIError
        raise ArgumentError, "Invalid request path #{path.inspect}: not a valid URL path"
      end

      unless parsed.scheme.nil? && parsed.host.nil?
        raise ArgumentError, "Invalid request path #{path.inspect}: a path may not specify " \
                             'a scheme or a host, only a location relative to the configured ' \
                             'API URL'
      end

      path
    end

    def unpack_url(url)
      path = URI.parse(url).path
      [URI.join(url).to_s, path == '/' ? '' : path]
    end
  end
end
