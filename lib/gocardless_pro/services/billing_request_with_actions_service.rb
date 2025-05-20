require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the BillingRequestWithAction endpoints
    class BillingRequestWithActionsService < BaseService
      # Creates a billing request and completes any specified actions in a single
      # request.
      # This endpoint allows you to create a billing request and immediately complete
      # actions
      # such as collecting customer details, bank account details, or other required
      # actions.
      # Example URL: /billing_requests/create_with_actions
      # @param options [Hash] parameters as a hash, under a params key.
      def create_with_actions(options = {})
        path = '/billing_requests/create_with_actions'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::BillingRequestWithAction.new(unenvelope_body(response.body), response)
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
        'billing_request_with_actions'
      end
    end
  end
end
