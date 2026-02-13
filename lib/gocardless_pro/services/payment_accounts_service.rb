require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the PaymentAccount endpoints
    class PaymentAccountsService < BaseService
      #  Retrieves the details of an existing payment account.
      # Example URL: /payment_accounts/:identity
      #
      # @param identity       #  Unique identifier, beginning with "BA".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/payment_accounts/:identity', {
                         'identity' => identity,
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::PaymentAccount.new(unenvelope_body(response.body), response)
      end

      #  Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      #  payment accounts.
      # Example URL: /payment_accounts
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/payment_accounts'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::PaymentAccount
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
        'payment_accounts'
      end
    end
  end
end
