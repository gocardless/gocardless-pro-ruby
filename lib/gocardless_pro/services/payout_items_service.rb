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
      # <div class="notice notice--warning u-block">
      #   <p><strong>Note</strong>: This endpoint is changing:</p>
      #
      #   <ul>
      #     <li>For payouts created from 1 November 2022, the payout items will be
      # sorted by payout item ID. For more details, see <a
      # href="https://hub.gocardless.com/s/article/FAQ-page-about-payout-items-API-change">this
      # FAQ page on the customer hub</a>.</li>
      #     <li>From 1 March 2023 onwards, we will only serve requests for payout
      # items created in the last 6 months. Requests for older payouts will return an
      # HTTP status <code>410 Gone</code>.</li>
      #   </ul>
      # </div>
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
