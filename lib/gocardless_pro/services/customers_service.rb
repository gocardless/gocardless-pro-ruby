require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Customer endpoints
    class CustomersService < BaseService
      # Creates a new customer object.
      # Example URL: /customers
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/customers'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        begin
          response = make_request(:post, path, options)

          # Response doesn't raise any errors until #body is called
          response.tap(&:body)
        rescue InvalidStateError => e
          if e.idempotent_creation_conflict?
            case @api_service.on_idempotency_conflict
            when :raise
              raise IdempotencyConflict, e.error
            when :fetch
              return get(e.conflicting_resource_id)
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::Customer.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # customers.
      # Example URL: /customers
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/customers'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Customer
        )
      end

      # Get a lazily enumerated list of all the items returned. This is similar to the `list` method but will paginate for you automatically.
      #
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          options: options
        ).enumerator
      end

      # Retrieves the details of an existing customer.
      # Example URL: /customers/:identity
      #
      # @param identity       # Unique identifier, beginning with "CU".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/customers/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::Customer.new(unenvelope_body(response.body), response)
      end

      # Updates a customer object. Supports all of the fields supported when creating
      # a customer.
      # Example URL: /customers/:identity
      #
      # @param identity       # Unique identifier, beginning with "CU".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/customers/:identity', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::Customer.new(unenvelope_body(response.body), response)
      end

      # Removed customers will not appear in search results or lists of customers (in
      # our API
      # or exports), and it will not be possible to load an individually removed
      # customer by
      # ID.
      #
      # <p class="restricted-notice"><strong>The action of removing a customer cannot
      # be reversed, so please use with care.</strong></p>
      # Example URL: /customers/:identity
      #
      # @param identity       # Unique identifier, beginning with "CU".
      # @param options [Hash] parameters as a hash, under a params key.
      def remove(identity, options = {})
        path = sub_url('/customers/:identity', 'identity' => identity)

        options[:retry_failures] = false

        response = make_request(:delete, path, options)

        return if response.body.nil?

        Resources::Customer.new(unenvelope_body(response.body), response)
      end

      private

      # Unenvelope the response of the body using the service's `envelope_key`
      #
      # @param body [Hash]
      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      # return the key which API responses will envelope data under
      def envelope_key
        'customers'
      end
    end
  end
end
