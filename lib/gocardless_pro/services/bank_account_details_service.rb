require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the BankAccountDetail endpoints
    class BankAccountDetailsService < BaseService
      # Returns bank account details in the flattened JSON Web Encryption format
      # described in RFC 7516
      # Example URL: /bank_account_details/:identity
      #
      # @param identity       # Unique identifier, beginning with "BA".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/bank_account_details/:identity', {
                         'identity' => identity
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::BankAccountDetail.new(unenvelope_body(response.body), response)
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
        'bank_account_details'
      end
    end
  end
end
