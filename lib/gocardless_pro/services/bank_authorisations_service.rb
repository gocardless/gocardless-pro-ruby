require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the BankAuthorisation endpoints
    class BankAuthorisationsService < BaseService
      # Fetches a bank authorisation
      # Example URL: /bank_authorisations/:identity
      #
      # @param identity       # Unique identifier, beginning with "BAU".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/bank_authorisations/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::BankAuthorisation.new(unenvelope_body(response.body), response)
      end

      # Create a Bank Authorisation.
      # Example URL: /bank_authorisations
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/bank_authorisations'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        begin
          response = make_request(:post, path, options)

          # Response doesn't raise any errors until #body is called
          response.tap(&:body)
        rescue InvalidStateError => e
          if e.idempotent_creation_conflict?
            case @api_service.on_idempotency_conflict
            when :raise
              raise IdempotencyConflict, e.error
            when :fetch
              return get(e.conflicting_resource_id)
            else
              raise ArgumentError, 'Unknown mode for :on_idempotency_conflict'
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::BankAuthorisation.new(unenvelope_body(response.body), response)
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
        'bank_authorisations'
      end
    end
  end
end
