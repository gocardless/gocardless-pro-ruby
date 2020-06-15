require 'cgi'

module GoCardlessPro
  # Module that contains all services for making requests to the API.
  module Services
    # Base Service that all services inherit from.
    class BaseService
      # Create a new service instance to make requests against
      #
      # @param api_service [GoCardlessPro::ApiService}}] an instance of the ApiService
      def initialize(api_service)
        @api_service = api_service
      end

      # Make a request to the API using the API service instance
      #
      # @param method [Symbol] the method to use to make the request
      # @param path [String] the URL (without the base domain) to make the request to
      # @param options [Hash] the options hash - either the query parameters for a GET, or the body if POST/PUT
      def make_request(method, path, options = {})
        @api_service.make_request(method, path, options.merge(envelope_key: envelope_key))
      end

      # Get the envelope key for the given service. Children are expected to implement this method.
      def envelope_key
        raise NotImplementedError
      end

      # take a URL with placeholder params and substitute them out for the actual value
      # @param url [String] the URL with placeholders in
      # @param param_map [Hash] a hash of placeholders and their actual values (which will be escaped)
      def sub_url(url, param_map)
        param_map.reduce(url) do |new_url, (param, value)|
          new_url.gsub(":#{param}", CGI.escape(value))
        end
      end
    end
  end
end
