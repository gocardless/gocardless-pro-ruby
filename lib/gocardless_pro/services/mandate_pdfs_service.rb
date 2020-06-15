require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the MandatePdf endpoints
    class MandatePdfsService < BaseService
      # Generates a PDF mandate and returns its temporary URL.
      #
      # Customer and bank account details can be left blank (for a blank mandate),
      # provided manually, or inferred from the ID of an existing
      # [mandate](#core-endpoints-mandates).
      #
      # By default, we'll generate PDF mandates in English.
      #
      # To generate a PDF mandate in another language, set the `Accept-Language`
      # header when creating the PDF mandate to the relevant [ISO
      # 639-1](http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) language code
      # supported for the scheme.
      #
      # | Scheme           | Supported languages
      #
      #     |
      # | :--------------- |
      # :-------------------------------------------------------------------------------------------------------------------------------------------
      # |
      # | ACH              | English (`en`)
      #
      #     |
      # | Autogiro         | English (`en`), Swedish (`sv`)
      #
      #     |
      # | Bacs             | English (`en`)
      #
      #     |
      # | BECS             | English (`en`)
      #
      #     |
      # | BECS NZ          | English (`en`)
      #
      #     |
      # | Betalingsservice | Danish (`da`), English (`en`)
      #
      #     |
      # | PAD              | English (`en`)
      #
      #     |
      # | SEPA Core        | Danish (`da`), Dutch (`nl`), English (`en`), French
      # (`fr`), German (`de`), Italian (`it`), Portuguese (`pt`), Spanish (`es`),
      # Swedish (`sv`) |
      # Example URL: /mandate_pdfs
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/mandate_pdfs'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::MandatePdf.new(unenvelope_body(response.body), response)
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
        'mandate_pdfs'
      end
    end
  end
end
