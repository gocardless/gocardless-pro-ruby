require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Refund endpoints
    class RefundsService < BaseService
      # Creates a new refund object.
      #
      # This fails with:<a name="total_amount_confirmation_invalid"></a><a
      # name="number_of_refunds_exceeded"></a><a
      # name="available_refund_amount_insufficient"></a>
      #
      # - `total_amount_confirmation_invalid` if the confirmation amount doesn't match
      # the total amount refunded for the payment. This safeguard is there to prevent
      # two processes from creating refunds without awareness of each other.
      #
      # - `available_refund_amount_insufficient` if the creditor does not have
      # sufficient balance for refunds available to cover the cost of the requested
      # refund.
      #
      # Example URL: /refunds
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/refunds'

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

        Resources::Refund.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # refunds.
      # Example URL: /refunds
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/refunds'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Refund
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

      # Retrieves all details for a single refund
      # Example URL: /refunds/:identity
      #
      # @param identity       # Unique identifier, beginning with "RF".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/refunds/:identity', {
                         'identity' => identity
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::Refund.new(unenvelope_body(response.body), response)
      end

      # Updates a refund object.
      # Example URL: /refunds/:identity
      #
      # @param identity       # Unique identifier, beginning with "RF".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/refunds/:identity', {
                         'identity' => identity
                       })

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::Refund.new(unenvelope_body(response.body), response)
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
        'refunds'
      end
    end
  end
end
