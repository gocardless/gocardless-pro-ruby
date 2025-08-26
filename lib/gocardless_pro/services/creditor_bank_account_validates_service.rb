require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the CreditorBankAccountValidate endpoints
    class CreditorBankAccountValidatesService < BaseService
      # Validate bank details without creating a creditor bank account
      # Example URL: /creditor_bank_accounts/validate
      # @param options [Hash] parameters as a hash, under a params key.
      def validate(options = {})
        path = '/creditor_bank_accounts/validate'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params

        options[:retry_failures] = false

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::CreditorBankAccountValidate.new(unenvelope_body(response.body), response)
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
    end
  end
end
