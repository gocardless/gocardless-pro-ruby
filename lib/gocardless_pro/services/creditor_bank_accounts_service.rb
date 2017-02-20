require_relative './base_service'
require 'uri'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the CreditorBankAccount endpoints
    class CreditorBankAccountsService < BaseService
      # Creates a new creditor bank account object.
      # Example URL: /creditor_bank_accounts
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/creditor_bank_accounts'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params
        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::CreditorBankAccount.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # creditor bank accounts.
      # Example URL: /creditor_bank_accounts
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/creditor_bank_accounts'

        response = make_request(:get, path, options)
        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::CreditorBankAccount
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

      # Retrieves the details of an existing creditor bank account.
      # Example URL: /creditor_bank_accounts/:identity
      #
      # @param identity       # Unique identifier, beginning with "BA".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/creditor_bank_accounts/:identity', 'identity' => identity)

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::CreditorBankAccount.new(unenvelope_body(response.body), response)
      end

      # Immediately disables the bank account, no money can be paid out to a disabled
      # account.
      #
      # This will return a `disable_failed` error if the bank account
      # has already been disabled.
      #
      # A disabled bank account can be re-enabled by
      # creating a new bank account resource with the same details.
      # Example URL: /creditor_bank_accounts/:identity/actions/disable
      #
      # @param identity       # Unique identifier, beginning with "BA".
      # @param options [Hash] parameters as a hash, under a params key.
      def disable(identity, options = {})
        path = sub_url('/creditor_bank_accounts/:identity/actions/disable', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params
        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::CreditorBankAccount.new(unenvelope_body(response.body), response)
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
        'creditor_bank_accounts'
      end

      # take a URL with placeholder params and substitute them out for the actual value
      # @param url [String] the URL with placeholders in
      # @param param_map [Hash] a hash of placeholders and their actual values (which will be escaped)
      def sub_url(url, param_map)
        param_map.reduce(url) do |new_url, (param, value)|
          new_url.gsub(":#{param}", URI.escape(value))
        end
      end
    end
  end
end
