require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Subscription endpoints
    class SubscriptionsService < BaseService
      # Creates a new subscription object
      # Example URL: /subscriptions
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/subscriptions'

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

        Resources::Subscription.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # subscriptions.
      # Example URL: /subscriptions
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/subscriptions'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Subscription
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

      # Retrieves the details of a single subscription.
      # Example URL: /subscriptions/:identity
      #
      # @param identity       # Unique identifier, beginning with "SB".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/subscriptions/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::Subscription.new(unenvelope_body(response.body), response)
      end

      # Updates a subscription object.
      #
      # This fails with:
      #
      # - `validation_failed` if invalid data is provided when attempting to update a
      # subscription.
      #
      # - `subscription_not_active` if the subscription is no longer active.
      #
      # - `subscription_already_ended` if the subscription has taken all payments.
      #
      # - `mandate_payments_require_approval` if the amount is being changed and the
      # mandate requires approval.
      #
      # - `number_of_subscription_amendments_exceeded` error if the subscription
      # amount has already been changed 10 times.
      #
      # - `forbidden` if the amount is being changed, and the subscription was created
      # by an app and you are not authenticated as that app, or if the subscription
      # was not created by an app and you are authenticated as an app
      #
      # - `resource_created_by_another_app` if the app fee is being changed, and the
      # subscription was created by an app other than the app you are authenticated as
      #
      # Example URL: /subscriptions/:identity
      #
      # @param identity       # Unique identifier, beginning with "SB".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/subscriptions/:identity', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::Subscription.new(unenvelope_body(response.body), response)
      end

      # Pause a subscription object.
      # No payments will be created until it is resumed.
      #
      # This can only be used when a subscription collecting a fixed number of
      # payments (created using `count`)
      # or when they continue forever (created without `count` or `end_date`)
      #
      # When `pause_cycles` is omitted the subscription is paused until the [resume
      # endpoint](#subscriptions-resume-a-subscription) is called.
      # If the subscription is collecting a fixed number of payments, `end_date` will
      # be set to `nil`.
      # When paused indefinitely, `upcoming_payments` will be empty.
      #
      # When `pause_cycles` is provided the subscription will be paused for the number
      # of cycles requested.
      # If the subscription is collecting a fixed number of payments, `end_date` will
      # be set to a new value.
      # When paused for a number of cycles, `upcoming_payments` will still contain the
      # upcoming charge dates.
      #
      # This fails with:
      #
      # - `forbidden` if the subscription was created by an app and you are not
      # authenticated as that app, or if the subscription was not created by an app
      # and you are authenticated as an app
      #
      # - `validation_failed` if invalid data is provided when attempting to pause a
      # subscription.
      #
      # - `subscription_not_active` if the subscription is no longer active.
      #
      # - `subscription_already_ended` if the subscription has taken all payments.
      #
      # - `pause_cycles_must_be_greater_than_or_equal_to` if the provided value for
      # `pause_cycles` cannot be satisfied.
      #
      # Example URL: /subscriptions/:identity/actions/pause
      #
      # @param identity       # Unique identifier, beginning with "SB".
      # @param options [Hash] parameters as a hash, under a params key.
      def pause(identity, options = {})
        path = sub_url('/subscriptions/:identity/actions/pause', 'identity' => identity)

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

        Resources::Subscription.new(unenvelope_body(response.body), response)
      end

      # Resume a subscription object.
      # Payments will start to be created again based on the subscriptions recurrence
      # rules.
      # The `charge_date` on the next payment will be the same as the subscriptions
      # `earliest_charge_date_after_resume`
      #
      # This fails with:
      #
      # - `forbidden` if the subscription was created by an app and you are not
      # authenticated as that app, or if the subscription was not created by an app
      # and you are authenticated as an app
      #
      # - `validation_failed` if invalid data is provided when attempting to resume a
      # subscription.
      #
      # - `subscription_not_paused` if the subscription is not paused.
      #
      # Example URL: /subscriptions/:identity/actions/resume
      #
      # @param identity       # Unique identifier, beginning with "SB".
      # @param options [Hash] parameters as a hash, under a params key.
      def resume(identity, options = {})
        path = sub_url('/subscriptions/:identity/actions/resume', 'identity' => identity)

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

        Resources::Subscription.new(unenvelope_body(response.body), response)
      end

      # Immediately cancels a subscription; no more payments will be created under it.
      # Any metadata supplied to this endpoint will be stored on the payment
      # cancellation event it causes.
      #
      # This will fail with a cancellation_failed error if the subscription is already
      # cancelled or finished.
      # Example URL: /subscriptions/:identity/actions/cancel
      #
      # @param identity       # Unique identifier, beginning with "SB".
      # @param options [Hash] parameters as a hash, under a params key.
      def cancel(identity, options = {})
        path = sub_url('/subscriptions/:identity/actions/cancel', 'identity' => identity)

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

        Resources::Subscription.new(unenvelope_body(response.body), response)
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
        'subscriptions'
      end
    end
  end
end
