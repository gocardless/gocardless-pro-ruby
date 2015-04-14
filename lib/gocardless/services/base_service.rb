module GoCardless
  # Module that contains all services for making requests to the API.
  module Services
    # Base Service that all services inherit from.
    class BaseService
      # Create a new service instance to make requests against
      #
      # @param api_service [GoCardless::ApiService}}] an instance of the ApiService
      def initialize(api_service)
        @api_service = api_service
      end

      # Make a request to the API using the API service instance
      #
      # @param method [Symbol] the method to use to make the request
      # @param path [String] the URL (without the base domain) to make the request to
      # @param options [Hash] the options hash - either the query parameters for a GET, or the body if POST/PUT
      # @param custom_headers [Hash] a hash of custom headers to use in the request
      def make_request(method, path, options = {}, custom_headers = {})
        @api_service.make_request(method, path, options.merge(envelope_key: envelope_key), custom_headers)
      end

      # Get the envelope key for the given service. Children are expected to implement this method.
      def envelope_key
        fail NotImplementedError
      end
    end
  end
end
