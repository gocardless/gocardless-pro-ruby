require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the InstalmentSchedule endpoints
    class InstalmentSchedulesService < BaseService
      # Creates a new instalment schedule object, along with the associated payments.
      # This
      # API is recommended if you know the specific dates you wish to charge.
      # Otherwise,
      # please check out the [scheduling
      # version](#instalment-schedules-create-with-schedule).
      #
      # The `instalments` property is an array of payment properties (`amount` and
      # `charge_date`).
      #
      # It can take quite a while to create the associated payments, so the API will
      # return
      # the status as `pending` initially. When processing has completed, a subsequent
      # GET
      # request for the instalment schedule will either have the status `success` and
      # link
      # to the created payments, or the status `error` and detailed information about
      # the
      # failures.
      # Example URL: /instalment_schedules
      # @param options [Hash] parameters as a hash, under a params key.
      def create_with_dates(options = {})
        path = '/instalment_schedules'

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

        Resources::InstalmentSchedule.new(unenvelope_body(response.body), response)
      end

      # Creates a new instalment schedule object, along with the associated payments.
      # This
      # API is recommended if you wish to use the GoCardless scheduling logic. For
      # finer
      # control over the individual dates, please check out the [alternative
      # version](#instalment-schedules-create-with-dates).
      #
      # It can take quite a while to create the associated payments, so the API will
      # return
      # the status as `pending` initially. When processing has completed, a subsequent
      # GET request for the instalment schedule will either have the status `success`
      # and link to
      # the created payments, or the status `error` and detailed information about the
      # failures.
      # Example URL: /instalment_schedules
      # @param options [Hash] parameters as a hash, under a params key.
      def create_with_schedule(options = {})
        path = '/instalment_schedules'

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

        Resources::InstalmentSchedule.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # instalment schedules.
      # Example URL: /instalment_schedules
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/instalment_schedules'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::InstalmentSchedule
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

      # Retrieves the details of an existing instalment schedule.
      # Example URL: /instalment_schedules/:identity
      #
      # @param identity       # Unique identifier, beginning with "IS".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/instalment_schedules/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::InstalmentSchedule.new(unenvelope_body(response.body), response)
      end

      # Updates an instalment schedule. This accepts only the metadata parameter.
      # Example URL: /instalment_schedules/:identity
      #
      # @param identity       # Unique identifier, beginning with "IS".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/instalment_schedules/:identity', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::InstalmentSchedule.new(unenvelope_body(response.body), response)
      end

      # Immediately cancels an instalment schedule; no further payments will be
      # collected for it.
      #
      # This will fail with a `cancellation_failed` error if the instalment schedule
      # is already cancelled or has completed.
      # Example URL: /instalment_schedules/:identity/actions/cancel
      #
      # @param identity       # Unique identifier, beginning with "IS".
      # @param options [Hash] parameters as a hash, under a params key.
      def cancel(identity, options = {})
        path = sub_url('/instalment_schedules/:identity/actions/cancel', 'identity' => identity)

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

        Resources::InstalmentSchedule.new(unenvelope_body(response.body), response)
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
        'instalment_schedules'
      end
    end
  end
end
