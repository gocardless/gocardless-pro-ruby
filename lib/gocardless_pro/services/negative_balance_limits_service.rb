require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the NegativeBalanceLimit endpoints
    class NegativeBalanceLimitsService < BaseService
      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of negative
      # balance limits.
      # Example URL: /negative_balance_limits
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/negative_balance_limits'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::NegativeBalanceLimit
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

      # Creates a new negative balance limit, which replaces the existing limit (if
      # present) for that currency and creditor combination.
      #
      # Example URL: /negative_balance_limits
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/negative_balance_limits'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::NegativeBalanceLimit.new(unenvelope_body(response.body), response)
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
        'negative_balance_limits'
      end
    end
  end
end
