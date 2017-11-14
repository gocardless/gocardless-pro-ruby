require_relative './base_service'
require 'uri'

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
      # To generate a PDF mandate in a foreign language, set your `Accept-Language`
      # header to the relevant [ISO
      # 639-1](http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes#Partial_ISO_639_table)
      # language code. Supported languages are Dutch, English, French, German,
      # Italian, Portuguese, Spanish and Swedish.
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
