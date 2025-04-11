require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the OutboundPayment endpoints
    class OutboundPaymentsService < BaseService
      #
      # Example URL: /outbound_payments
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/outbound_payments'

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

        Resources::OutboundPayment.new(unenvelope_body(response.body), response)
      end

      # Creates an outbound payment to your verified business bank account as the
      # recipient.
      # Example URL: /outbound_payments/withdrawal
      # @param options [Hash] parameters as a hash, under a params key.
      def withdraw(options = {})
        path = '/outbound_payments/withdrawal'

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

        Resources::OutboundPayment.new(unenvelope_body(response.body), response)
      end

      # Cancels an outbound payment. Only outbound payments with either `verifying`,
      # `pending_approval`, or `scheduled` status can be cancelled.
      # Once an outbound payment is `executing`, the money moving process has begun
      # and cannot be reversed.
      # Example URL: /outbound_payments/:identity/actions/cancel
      #
      # @param identity       # Unique identifier of the outbound payment.
      # @param options [Hash] parameters as a hash, under a params key.
      def cancel(identity, options = {})
        path = sub_url('/outbound_payments/:identity/actions/cancel', {
                         'identity' => identity
                       })

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

        Resources::OutboundPayment.new(unenvelope_body(response.body), response)
      end

      # Approves an outbound payment. Only outbound payments in the “pending_approval”
      # state can be approved.
      # Example URL: /outbound_payments/:identity/actions/approve
      #
      # @param identity       # Unique identifier of the outbound payment.
      # @param options [Hash] parameters as a hash, under a params key.
      def approve(identity, options = {})
        path = sub_url('/outbound_payments/:identity/actions/approve', {
                         'identity' => identity
                       })

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

        Resources::OutboundPayment.new(unenvelope_body(response.body), response)
      end

      # Fetches an outbound_payment by ID
      # Example URL: /outbound_payments/:identity
      #
      # @param identity       # Unique identifier of the outbound payment.
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/outbound_payments/:identity', {
                         'identity' => identity
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::OutboundPayment.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of outbound
      # payments.
      # Example URL: /outbound_payments
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/outbound_payments'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::OutboundPayment
        )
      end

      # Get a lazily enumerated list of all the items returned. This is similar to the `list` method but will paginate for you automatically.
      #
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          options: options
        ).enumerator
      end

      # Updates an outbound payment object. This accepts only the metadata parameter.
      # Example URL: /outbound_payments/:identity
      #
      # @param identity       # Unique identifier of the outbound payment.
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/outbound_payments/:identity', {
                         'identity' => identity
                       })

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::OutboundPayment.new(unenvelope_body(response.body), response)
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
        'outbound_payments'
      end
    end
  end
end
