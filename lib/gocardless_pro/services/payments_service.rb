require_relative './base_service'
require 'uri'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Payment endpoints
    class PaymentsService < BaseService
      # <a name="mandate_is_inactive"></a>Creates a new payment object.
      #
      # This fails with a `mandate_is_inactive` error if the linked
      # [mandate](#core-endpoints-mandates) is cancelled or has failed. Payments can
      # be created against mandates with status of: `pending_customer_approval`,
      # `pending_submission`, `submitted`, and `active`.
      # Example URL: /payments
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/payments'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        begin
          response = make_request(:post, path, options)

          # Response doesn't raise any errors until #body is called
          response.tap(&:body)
        rescue InvalidStateError => e
          return get(e.conflicting_resource_id) if e.idempotent_creation_conflict?

          raise e
        end

        return if response.body.nil?

        Resources::Payment.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # payments.
      # Example URL: /payments
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/payments'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Payment
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

      # Retrieves the details of a single existing payment.
      # Example URL: /payments/:identity
      #
      # @param identity       # Unique identifier, beginning with "PM".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/payments/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::Payment.new(unenvelope_body(response.body), response)
      end

      # Updates a payment object. This accepts only the metadata parameter.
      # Example URL: /payments/:identity
      #
      # @param identity       # Unique identifier, beginning with "PM".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/payments/:identity', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::Payment.new(unenvelope_body(response.body), response)
      end

      # Cancels the payment if it has not already been submitted to the banks. Any
      # metadata supplied to this endpoint will be stored on the payment cancellation
      # event it causes.
      #
      # This will fail with a `cancellation_failed` error unless the payment's status
      # is `pending_submission`.
      # Example URL: /payments/:identity/actions/cancel
      #
      # @param identity       # Unique identifier, beginning with "PM".
      # @param options [Hash] parameters as a hash, under a params key.
      def cancel(identity, options = {})
        path = sub_url('/payments/:identity/actions/cancel', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params

        options[:retry_failures] = false

        begin
          response = make_request(:post, path, options)

          # Response doesn't raise any errors until #body is called
          response.tap(&:body)
        rescue InvalidStateError => e
          return get(e.conflicting_resource_id) if e.idempotent_creation_conflict?

          raise e
        end

        return if response.body.nil?

        Resources::Payment.new(unenvelope_body(response.body), response)
      end

      # <a name="retry_failed"></a>Retries a failed payment if the underlying mandate
      # is active. You will receive a `resubmission_requested` webhook, but after that
      # retrying the payment follows the same process as its initial creation, so you
      # will receive a `submitted` webhook, followed by a `confirmed` or `failed`
      # event. Any metadata supplied to this endpoint will be stored against the
      # payment submission event it causes.
      #
      # This will return a `retry_failed` error if the payment has not failed.
      #
      # Payments can be retried up to 3 times.
      # Example URL: /payments/:identity/actions/retry
      #
      # @param identity       # Unique identifier, beginning with "PM".
      # @param options [Hash] parameters as a hash, under a params key.
      def retry(identity, options = {})
        path = sub_url('/payments/:identity/actions/retry', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params

        options[:retry_failures] = false

        begin
          response = make_request(:post, path, options)

          # Response doesn't raise any errors until #body is called
          response.tap(&:body)
        rescue InvalidStateError => e
          return get(e.conflicting_resource_id) if e.idempotent_creation_conflict?

          raise e
        end

        return if response.body.nil?

        Resources::Payment.new(unenvelope_body(response.body), response)
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
        'payments'
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
