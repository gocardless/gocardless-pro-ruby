require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Logo endpoints
    class LogosService < BaseService
      # Creates a new logo associated with a creditor. If a creditor already has a
      # logo, this will update the existing logo linked to the creditor.
      #
      # We support JPG and PNG formats. Your logo will be scaled to a maximum of 300px
      # by 40px. For more guidance on how to upload logos that will look
      # great across your customer payment page and notification emails see
      # [here](https://developer.gocardless.com/gc-embed/setting-up-branding#tips_for_uploading_your_logo).
      # Example URL: /branding/logos
      # @param options [Hash] parameters as a hash, under a params key.
      def create_for_creditor(options = {})
        path = '/branding/logos'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::Logo.new(unenvelope_body(response.body), response)
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
        'logos'
      end
    end
  end
end
