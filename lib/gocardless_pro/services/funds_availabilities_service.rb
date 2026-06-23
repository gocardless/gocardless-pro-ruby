require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the FundsAvailability endpoints
    class FundsAvailabilitiesService < BaseService
      # Checks if the payer's current balance is sufficient to cover the amount
      # the merchant wants to charge within the consent parameters defined on the
      # mandate.
      # Example URL: /funds_availability/:identity
      #
      # @param identity       # Unique identifier, beginning with "MD". Note that this prefix may not
      # apply to mandates created before 2016.
      # @param options [Hash] parameters as a hash, under a params key.
      def check(identity, options = {})
        path = sub_url('/funds_availability/:identity', {
                         'identity' => identity,
                       })

        options[:retry_failures] = false

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::FundsAvailability.new(unenvelope_body(response.body), response)
      end

      private

      # Unenvelope the response of the body using the service's `envelope_key`
      #
      # @param body [Hash]
      def unenvelope_body(body)
        if body.key?(envelope_key)
          body[envelope_key]
        elsif body.key?('data')
          body['data']
        else
          body
        end
      end

      # return the key which API responses will envelope data under
      def envelope_key
        'funds_availability'
      end
    end
  end
end
