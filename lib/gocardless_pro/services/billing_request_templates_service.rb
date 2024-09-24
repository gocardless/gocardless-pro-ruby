require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the BillingRequestTemplate endpoints
    class BillingRequestTemplatesService < BaseService
      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # Billing Request Templates.
      # Example URL: /billing_request_templates
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/billing_request_templates'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::BillingRequestTemplate
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

      # Fetches a Billing Request Template
      # Example URL: /billing_request_templates/:identity
      #
      # @param identity       # Unique identifier, beginning with "BRT".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/billing_request_templates/:identity', {
                         'identity' => identity
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::BillingRequestTemplate.new(unenvelope_body(response.body), response)
      end

      #
      # Example URL: /billing_request_templates
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/billing_request_templates'

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

        Resources::BillingRequestTemplate.new(unenvelope_body(response.body), response)
      end

      # Updates a Billing Request Template, which will affect all future Billing
      # Requests created by this template.
      # Example URL: /billing_request_templates/:identity
      #
      # @param identity       # Unique identifier, beginning with "BRQ".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/billing_request_templates/:identity', {
                         'identity' => identity
                       })

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::BillingRequestTemplate.new(unenvelope_body(response.body), response)
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
        'billing_request_templates'
      end
    end
  end
end
