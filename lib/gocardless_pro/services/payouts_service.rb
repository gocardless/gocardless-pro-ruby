require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Payout endpoints
    class PayoutsService < BaseService
      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # payouts.
      # Example URL: /payouts
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/payouts'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Payout
        )
      end

      # Get a lazily enumerated list of all the items returned. This is simmilar to the `list` method but will paginate for you automatically.
      #
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          options: options
        ).enumerator
      end

      # Retrieves the details of a single payout. For an example of how to reconcile
      # the transactions in a payout, see [this
      # guide](#events-reconciling-payouts-with-events).
      # Example URL: /payouts/:identity
      #
      # @param identity       # Unique identifier, beginning with "PO".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/payouts/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::Payout.new(unenvelope_body(response.body), response)
      end

      # Updates a payout object. This accepts only the metadata parameter.
      # Example URL: /payouts/:identity
      #
      # @param identity       # Unique identifier, beginning with "PO".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/payouts/:identity', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::Payout.new(unenvelope_body(response.body), response)
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
        'payouts'
      end
    end
  end
end
