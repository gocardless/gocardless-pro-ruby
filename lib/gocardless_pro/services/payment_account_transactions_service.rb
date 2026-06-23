require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the PaymentAccountTransaction endpoints
    class PaymentAccountTransactionsService < BaseService
      # Retrieves the details of an existing payment account transaction.
      # Example URL: /payment_account_transactions/:identity
      #
      # @param identity       # The unique ID of the [bank
      # account](#core-endpoints-creditor-bank-accounts) which happens to be the
      # payment account.
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/payment_account_transactions/:identity', {
                         'identity' => identity,
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::PaymentAccountTransaction.new(unenvelope_body(response.body), response)
      end

      # List transactions for a given payment account.
      # Example URL: /payment_accounts/:identity/transactions
      #
      # @param identity       # The unique ID of the [bank
      # account](#core-endpoints-creditor-bank-accounts) which happens to be the
      # payment account.
      # @param options [Hash] parameters as a hash, under a params key.
      def list(identity, options = {})
        path = sub_url('/payment_accounts/:identity/transactions', {
                         'identity' => identity,
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::PaymentAccountTransaction
        )
      end

      # Get a lazily enumerated list of all the items returned. This is similar to the `list` method but will paginate for you automatically.
      #
      # @param identity       # The unique ID of the [bank
      # account](#core-endpoints-creditor-bank-accounts) which happens to be the
      # payment account.
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(identity, options = {})
        Paginator.new(
          service: self,
          options: options,
          identity: identity
        ).enumerator
      end

      private

      # Unenvelope the response of the body using the service's `envelope_key`
      #
      # @param body [Hash]
      def unenvelope_body(body)
        if body.key?(envelope_key)
          body[envelope_key]
        elsif body.key?('data')
          body['data']
        else
          body
        end
      end

      # return the key which API responses will envelope data under
      def envelope_key
        'payment_account_transactions'
      end
    end
  end
end
