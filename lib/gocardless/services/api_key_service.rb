require_relative './base_service'

# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank

module GoCardless
  module Services
    class ApiKeyService < BaseService
      # Creates a new API key.
      # Example URL: /api_keys
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def create(options = {}, custom_headers = {})
        path = '/api_keys'
        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)

        Resources::ApiKey.new(unenvelope_body(response.body))
      end

      # Returns a
      # [cursor-paginated](https://developer.gocardless.com/pro/#overview-cursor-pagination)
      # list of your API keys.
      # Example URL: /api_keys
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def list(options = {}, custom_headers = {})
        path = '/api_keys'

        response = make_request(:get, path, options, custom_headers)
        ListResponse.new(
          raw_response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::ApiKey
        )
      end

      # Get a lazily enumerated list of all the items returned. This is simmilar to the `list` method but will paginate for you automatically.
      #
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          path: '/api_keys',
          options: options
        ).enumerator
      end

      # Retrieves the details of an existing API key.
      # Example URL: /api_keys/:identity
      #
      # @param identity:       # Unique identifier, beginning with "AK" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def get(identity, options = {}, custom_headers = {})
        path = sub_url('/api_keys/:identity',           'identity' => identity)

        response = make_request(:get, path, options, custom_headers)

        Resources::ApiKey.new(unenvelope_body(response.body))
      end

      # Updates an API key. Only the `name` and `webhook_url` fields are supported.
      # Example URL: /api_keys/:identity
      #
      # @param identity:       # Unique identifier, beginning with "AK" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def update(identity, options = {}, custom_headers = {})
        path = sub_url('/api_keys/:identity',           'identity' => identity)

        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:put, path, options, custom_headers)

        Resources::ApiKey.new(unenvelope_body(response.body))
      end

      # Disables an API key. Once disabled, the API key will not be usable to
      # authenticate any requests, and its `webhook_url` will not receive any more
      # events.
      # Example URL: /api_keys/:identity/actions/disable
      #
      # @param identity:       # Unique identifier, beginning with "AK" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def disable(identity, options = {}, custom_headers = {})
        path = sub_url('/api_keys/:identity/actions/disable',           'identity' => identity)

        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)

        Resources::ApiKey.new(unenvelope_body(response.body))
      end

      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      private

      def envelope_key
        'api_keys'
      end

      def sub_url(url, param_map)
        param_map.reduce(url) do |new_url, (param, value)|
          new_url.gsub(":#{param}", value)
        end
      end
    end
  end
end
