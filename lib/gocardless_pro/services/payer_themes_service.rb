require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the PayerTheme endpoints
    class PayerThemesService < BaseService
      # Creates a new payer theme associated with a creditor. If a creditor already
      # has payer themes, this will update the existing payer theme linked to the
      # creditor.
      # Example URL: /branding/payer_themes
      # @param options [Hash] parameters as a hash, under a params key.
      def create_for_creditor(options = {})
        path = '/branding/payer_themes'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::PayerTheme.new(unenvelope_body(response.body), response)
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
        'payer_themes'
      end
    end
  end
end
