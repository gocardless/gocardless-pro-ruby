require_relative './base_service'
require 'uri'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the BankDetailsLookup endpoints
    class BankDetailsLookupsService < BaseService
      # Performs a bank details lookup. As part of the lookup, a modulus check and
      # reachability check are performed.
      #
      # If your request returns an [error](#api-usage-errors) or the
      # `available_debit_schemes`
      # attribute is an empty array, you will not be able to collect payments from the
      # specified bank account. GoCardless may be able to collect payments from an
      # account
      # even if no `bic` is returned.
      #
      # Bank account details may be supplied using [local
      # details](#appendix-local-bank-details) or an IBAN.
      #
      # _Note:_ Usage of this endpoint is monitored. If your organisation relies on
      # GoCardless for
      # modulus or reachability checking but not for payment collection, please get in
      # touch.
      # Example URL: /bank_details_lookups
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/bank_details_lookups'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::BankDetailsLookup.new(unenvelope_body(response.body), response)
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
        'bank_details_lookups'
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
