require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the BankAccountHolderVerification endpoints
    class BankAccountHolderVerificationsService < BaseService
      #  Verify the account holder of the bank account. A complete verification can be
      #  attached when creating an outbound payment. This endpoint allows partner
      #  merchants to create Confirmation of Payee checks on customer bank accounts
      #  before sending outbound payments.
      # Example URL: /bank_account_holder_verifications
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/bank_account_holder_verifications'

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
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::BankAccountHolderVerification.new(unenvelope_body(response.body), response)
      end

      #  Fetches a bank account holder verification by ID.
      # Example URL: /bank_account_holder_verifications/:identity
      #
      # @param identity       #  The unique identifier for the bank account holder verification
      #  resource, e.g. "BAHV123".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/bank_account_holder_verifications/:identity', {
                         'identity' => identity,
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::BankAccountHolderVerification.new(unenvelope_body(response.body), response)
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
        'bank_account_holder_verifications'
      end
    end
  end
end
