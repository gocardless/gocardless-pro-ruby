require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the CustomerBankAccount endpoints
    class CustomerBankAccountsService < BaseService
      # Creates a new customer bank account object.
      #
      # There are three different ways to supply bank account details:
      #
      # - [Local details](#appendix-local-bank-details)
      #
      # - IBAN
      #
      # - [Customer Bank Account
      # Tokens](#javascript-flow-create-a-customer-bank-account-token)
      #
      # For more information on the different fields required in each country, see
      # [local bank details](#appendix-local-bank-details).
      # Example URL: /customer_bank_accounts
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/customer_bank_accounts'

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

        Resources::CustomerBankAccount.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your bank
      # accounts.
      # Example URL: /customer_bank_accounts
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/customer_bank_accounts'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::CustomerBankAccount
        )
      end

      # Get a lazily enumerated list of all the items returned. This is simmilar to the `list` method but will paginate for you automatically.
      #
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          options: options
        ).enumerator
      end

      # Retrieves the details of an existing bank account.
      # Example URL: /customer_bank_accounts/:identity
      #
      # @param identity       # Unique identifier, beginning with "BA".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/customer_bank_accounts/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::CustomerBankAccount.new(unenvelope_body(response.body), response)
      end

      # Updates a customer bank account object. Only the metadata parameter is
      # allowed.
      # Example URL: /customer_bank_accounts/:identity
      #
      # @param identity       # Unique identifier, beginning with "BA".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/customer_bank_accounts/:identity', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::CustomerBankAccount.new(unenvelope_body(response.body), response)
      end

      # Immediately cancels all associated mandates and cancellable payments.
      #
      # This will return a `disable_failed` error if the bank account has already been
      # disabled.
      #
      # A disabled bank account can be re-enabled by creating a new bank account
      # resource with the same details.
      # Example URL: /customer_bank_accounts/:identity/actions/disable
      #
      # @param identity       # Unique identifier, beginning with "BA".
      # @param options [Hash] parameters as a hash, under a params key.
      def disable(identity, options = {})
        path = sub_url('/customer_bank_accounts/:identity/actions/disable', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params

        options[:retry_failures] = false

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

        Resources::CustomerBankAccount.new(unenvelope_body(response.body), response)
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
        'customer_bank_accounts'
      end
    end
  end
end
