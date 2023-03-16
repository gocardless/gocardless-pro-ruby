require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Institution endpoints
    class InstitutionsService < BaseService
      # Returns a list of supported institutions.
      #
      # <p class="deprecated-notice"><strong>Deprecated</strong>: This list
      # institutions endpoint
      # is no longer supported. We strongly recommend using the
      # [List Institutions For Billing
      # Request](#institutions-list-institutions-for-billing-request)
      # instead.</p>
      # Example URL: /institutions
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/institutions'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Institution
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

      # Returns all institutions valid for a Billing Request.
      #
      # This endpoint is currently supported only for FasterPayments.
      # Example URL: /billing_requests/:identity/institutions
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def list_for_billing_request(identity, options = {})
        path = sub_url('/billing_requests/:identity/institutions', {
                         'identity' => identity,
                       })

        options[:retry_failures] = false

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Institution
        )
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
        'institutions'
      end
    end
  end
end
