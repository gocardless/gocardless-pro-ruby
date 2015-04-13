require_relative './base_service'

# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank

module GoCardless
  module Services
    class PaymentService < BaseService
      # <a name="mandate_is_inactive"></a>Creates a new payment object.
      #
      # This
      # fails with a `mandate_is_inactive` error if the linked
      # [mandate](https://developer.gocardless.com/pro/#api-endpoints-mandates) is
      # cancelled. Payments can be created against `pending_submission` mandates, but
      # they will not be submitted until the mandate becomes active.
      # Example URL: /payments
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def create(options = {}, custom_headers = {})
        path = '/payments'
        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)

        Resources::Payment.new(unenvelope_body(response.body))
      end

      # Returns a
      # [cursor-paginated](https://developer.gocardless.com/pro/#overview-cursor-pagination)
      # list of your payments.
      # Example URL: /payments
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def list(options = {}, custom_headers = {})
        path = '/payments'

        response = make_request(:get, path, options, custom_headers)
        ListResponse.new(
          raw_response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Payment
        )
      end

      # Get a lazily enumerated list of all the items returned. This is simmilar to the `list` method but will paginate for you automatically.
      #
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          path: '/payments',
          options: options
        ).enumerator
      end

      # Retrieves the details of a single existing payment.
      # Example URL: /payments/:identity
      #
      # @param identity:       # Unique identifier, beginning with "PM" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def get(identity, options = {}, custom_headers = {})
        path = sub_url('/payments/:identity',           'identity' => identity)

        response = make_request(:get, path, options, custom_headers)

        Resources::Payment.new(unenvelope_body(response.body))
      end

      # Updates a payment object. This accepts only the metadata parameter.
      # Example URL: /payments/:identity
      #
      # @param identity:       # Unique identifier, beginning with "PM" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def update(identity, options = {}, custom_headers = {})
        path = sub_url('/payments/:identity',           'identity' => identity)

        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:put, path, options, custom_headers)

        Resources::Payment.new(unenvelope_body(response.body))
      end

      # Cancels the payment if it has not already been submitted to the banks. Any
      # metadata supplied to this endpoint will be stored on the payment cancellation
      # event it causes.
      #
      # This will fail with a `cancellation_failed` error unless
      # the payment's status is `pending_submission`.
      # Example URL: /payments/:identity/actions/cancel
      #
      # @param identity:       # Unique identifier, beginning with "PM" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def cancel(identity, options = {}, custom_headers = {})
        path = sub_url('/payments/:identity/actions/cancel',           'identity' => identity)

        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)

        Resources::Payment.new(unenvelope_body(response.body))
      end

      # <a name="retry_failed"></a>Retries a failed payment if the underlying mandate
      # is active. You will receive a `resubmission_requested` webhook, but after that
      # retrying the payment follows the same process as its initial creation, so you
      # will receive a `submitted` webhook, followed by a `confirmed` or `failed`
      # event. Any metadata supplied to this endpoint will be stored against the
      # payment submission event it causes.
      #
      # This will return a `retry_failed`
      # error if the payment has not failed.
      # Example URL: /payments/:identity/actions/retry
      #
      # @param identity:       # Unique identifier, beginning with "PM" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def retry(identity, options = {}, custom_headers = {})
        path = sub_url('/payments/:identity/actions/retry',           'identity' => identity)

        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)

        Resources::Payment.new(unenvelope_body(response.body))
      end

      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      private

      def envelope_key
        'payments'
      end

      def sub_url(url, param_map)
        param_map.reduce(url) do |new_url, (param, value)|
          new_url.gsub(":#{param}", value)
        end
      end
    end
  end
end
