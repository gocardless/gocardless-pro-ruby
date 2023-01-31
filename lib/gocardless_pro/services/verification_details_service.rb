require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the VerificationDetail endpoints
    class VerificationDetailsService < BaseService
      # Verification details represent any information needed by GoCardless to verify
      # a creditor.
      # Currently, only UK-based companies are supported.
      # In other words, to submit verification details for a creditor, their
      # creditor_type must be company and their country_code must be GB.
      # Example URL: /verification_details
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/verification_details'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::VerificationDetail.new(unenvelope_body(response.body), response)
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
        'verification_details'
      end
    end
  end
end
