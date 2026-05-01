require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the OutboundPaymentImport endpoints
    class OutboundPaymentImportsService < BaseService
      #
      # Example URL: /outbound_payment_imports
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/outbound_payment_imports'

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
              raise IdempotencyConflict.new(e.error)
            when :fetch
              return get(e.conflicting_resource_id)
            end
          end

          raise e
        end

        return if response.body.nil?

        Resources::OutboundPaymentImport.new(unenvelope_body(response.body), response)
      end

      # Returns a single outbound payment import.
      # Example URL: /outbound_payment_imports/:identity
      #
      # @param identity       # Unique identifier, beginning with "IM".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/outbound_payment_imports/:identity', {
                         'identity' => identity,
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::OutboundPaymentImport.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # outbound payment imports.
      # Example URL: /outbound_payment_imports
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/outbound_payment_imports'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::OutboundPaymentImport
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

      private

      # Unenvelope the response of the body using the service's `envelope_key`
      #
      # @param body [Hash]
      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      # return the key which API responses will envelope data under
      def envelope_key
        'outbound_payment_imports'
      end
    end
  end
end
