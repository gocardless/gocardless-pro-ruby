require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the TransferredMandate endpoints
    class TransferredMandatesService < BaseService
      # Returns encrypted bank details for the transferred mandate
      # Example URL: /transferred_mandate/:identity
      #
      # @param identity       # Unique identifier, beginning with "MD". Note that this prefix may not
      # apply to mandates created before 2016.
      # @param options [Hash] parameters as a hash, under a params key.
      def transferred_mandates(identity, options = {})
        path = sub_url('/transferred_mandate/:identity', {
                         'identity' => identity,
                       })

        options[:retry_failures] = false

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::TransferredMandate.new(unenvelope_body(response.body), response)
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
        'transferred_mandate'
      end
    end
  end
end
