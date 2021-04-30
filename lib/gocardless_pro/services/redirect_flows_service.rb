require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the RedirectFlow endpoints
    class RedirectFlowsService < BaseService
      # Creates a redirect flow object which can then be used to redirect your
      # customer to the GoCardless hosted payment pages.
      # Example URL: /redirect_flows
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/redirect_flows'

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

        Resources::RedirectFlow.new(unenvelope_body(response.body), response)
      end

      # Returns all details about a single redirect flow
      # Example URL: /redirect_flows/:identity
      #
      # @param identity       # Unique identifier, beginning with "RE".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/redirect_flows/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::RedirectFlow.new(unenvelope_body(response.body), response)
      end

      # This creates a [customer](#core-endpoints-customers), [customer bank
      # account](#core-endpoints-customer-bank-accounts), and
      # [mandate](#core-endpoints-mandates) using the details supplied by your
      # customer and returns the ID of the created mandate.
      #
      # This will return a `redirect_flow_incomplete` error if your customer has not
      # yet been redirected back to your site, and a `redirect_flow_already_completed`
      # error if your integration has already completed this flow. It will return a
      # `bad_request` error if the `session_token` differs to the one supplied when
      # the redirect flow was created.
      # Example URL: /redirect_flows/:identity/actions/complete
      #
      # @param identity       # Unique identifier, beginning with "RE".
      # @param options [Hash] parameters as a hash, under a params key.
      def complete(identity, options = {})
        path = sub_url('/redirect_flows/:identity/actions/complete', 'identity' => identity)

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

        Resources::RedirectFlow.new(unenvelope_body(response.body), response)
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
        'redirect_flows'
      end
    end
  end
end
