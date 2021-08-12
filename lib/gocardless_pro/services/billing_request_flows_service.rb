require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the BillingRequestFlow endpoints
    class BillingRequestFlowsService < BaseService
      # Creates a new billing request flow.
      # Example URL: /billing_request_flows
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/billing_request_flows'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::BillingRequestFlow.new(unenvelope_body(response.body), response)
      end

      # Returns the flow having generated a fresh session token which can be used to
      # power
      # integrations that manipulate the flow.
      # Example URL: /billing_request_flows/:identity/actions/initialise
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def initialise(identity, options = {})
        path = sub_url('/billing_request_flows/:identity/actions/initialise', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params

        options[:retry_failures] = false

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::BillingRequestFlow.new(unenvelope_body(response.body), response)
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
        'billing_request_flows'
      end
    end
  end
end
