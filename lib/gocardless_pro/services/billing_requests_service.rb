require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the BillingRequest endpoints
    class BillingRequestsService < BaseService
      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # billing_requests.
      # Example URL: /billing_requests
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/billing_requests'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::BillingRequest
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

      #
      # Example URL: /billing_requests
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/billing_requests'

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

        Resources::BillingRequest.new(unenvelope_body(response.body), response)
      end

      # Fetches a billing request
      # Example URL: /billing_requests/:identity
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/billing_requests/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::BillingRequest.new(unenvelope_body(response.body), response)
      end

      # If the billing request has a pending <code>collect_customer_details</code>
      # action, this endpoint can be used to collect the details in order to
      # complete it.
      #
      # The endpoint takes the same payload as Customers, but checks that the
      # customer fields are populated correctly for the billing request scheme.
      #
      # Whatever is provided to this endpoint is used to update the referenced
      # customer, and will take effect immediately after the request is
      # successful.
      # Example URL: /billing_requests/:identity/actions/collect_customer_details
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def collect_customer_details(identity, options = {})
        path = sub_url('/billing_requests/:identity/actions/collect_customer_details', 'identity' => identity)

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
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::BillingRequest.new(unenvelope_body(response.body), response)
      end

      # If the billing request has a pending
      # <code>collect_bank_account</code> action, this endpoint can be
      # used to collect the details in order to complete it.
      #
      # The endpoint takes the same payload as Customer Bank Accounts, but check
      # the bank account is valid for the billing request scheme before creating
      # and attaching it.
      # Example URL: /billing_requests/:identity/actions/collect_bank_account
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def collect_bank_account(identity, options = {})
        path = sub_url('/billing_requests/:identity/actions/collect_bank_account', 'identity' => identity)

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
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::BillingRequest.new(unenvelope_body(response.body), response)
      end

      # If a billing request is ready to be fulfilled, call this endpoint to cause
      # it to fulfil, executing the payment.
      # Example URL: /billing_requests/:identity/actions/fulfil
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def fulfil(identity, options = {})
        path = sub_url('/billing_requests/:identity/actions/fulfil', 'identity' => identity)

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
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::BillingRequest.new(unenvelope_body(response.body), response)
      end

      # This is needed when you have mandate_request. As a scheme compliance rule we
      # are required to
      # allow the payer to crosscheck the details entered by them and confirm it.
      # Example URL: /billing_requests/:identity/actions/confirm_payer_details
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def confirm_payer_details(identity, options = {})
        path = sub_url('/billing_requests/:identity/actions/confirm_payer_details', 'identity' => identity)

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
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::BillingRequest.new(unenvelope_body(response.body), response)
      end

      # Immediately cancels a billing request, causing all billing request flows
      # to expire.
      # Example URL: /billing_requests/:identity/actions/cancel
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def cancel(identity, options = {})
        path = sub_url('/billing_requests/:identity/actions/cancel', 'identity' => identity)

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
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::BillingRequest.new(unenvelope_body(response.body), response)
      end

      # Notifies the customer linked to the billing request, asking them to authorise
      # it.
      # Currently, the customer can only be notified by email.
      # Example URL: /billing_requests/:identity/actions/notify
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def notify(identity, options = {})
        path = sub_url('/billing_requests/:identity/actions/notify', 'identity' => identity)

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
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::BillingRequest.new(unenvelope_body(response.body), response)
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
        'billing_requests'
      end
    end
  end
end
