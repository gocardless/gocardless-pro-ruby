require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the PayoutItem endpoints
    class PayoutItemsService < BaseService
      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of items in
      # the payout.
      #
      # <strong>This endpoint only serves requests for payouts created in the last 6
      # months. Requests for older payouts will return an HTTP status <code>410
      # Gone</code>.</strong>
      #
      # Example URL: /payout_items
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/payout_items'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::PayoutItem
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

      private

      # Unenvelope the response of the body using the service's `envelope_key`
      #
      # @param body [Hash]
      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      # return the key which API responses will envelope data under
      def envelope_key
        'payout_items'
      end
    end
  end
end
