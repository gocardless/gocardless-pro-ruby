require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the PayerAuthorisation endpoints
    class PayerAuthorisationsService < BaseService
      # Retrieves the details of a single existing Payer Authorisation. It can be used
      # for polling the status of a Payer Authorisation.
      # Example URL: /payer_authorisations/:identity
      #
      # @param identity       # Unique identifier, beginning with "PA".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/payer_authorisations/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::PayerAuthorisation.new(unenvelope_body(response.body), response)
      end

      # Creates a Payer Authorisation. The resource is saved to the database even if
      # incomplete. An empty array of incomplete_fields means that the resource is
      # valid. The ID of the resource is used for the other actions. This endpoint has
      # been designed this way so you do not need to save any payer data on your
      # servers or the browser while still being able to implement a progressive
      # solution, such as a multi-step form.
      # Example URL: /payer_authorisations
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/payer_authorisations'

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

        Resources::PayerAuthorisation.new(unenvelope_body(response.body), response)
      end

      # Updates a Payer Authorisation. Updates the Payer Authorisation with the
      # request data. Can be invoked as many times as needed. Only fields present in
      # the request will be modified. An empty array of incomplete_fields means that
      # the resource is valid. This endpoint has been designed this way so you do not
      # need to save any payer data on your servers or the browser while still being
      # able to implement a progressive solution, such a multi-step form. <p
      # class="notice"> Note that in order to update the `metadata` attribute values
      # it must be sent completely as it overrides the previously existing values.
      # </p>
      # Example URL: /payer_authorisations/:identity
      #
      # @param identity       # Unique identifier, beginning with "PA".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/payer_authorisations/:identity', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::PayerAuthorisation.new(unenvelope_body(response.body), response)
      end

      # Submits all the data previously pushed to this PayerAuthorisation for
      # verification. This time, a 200 HTTP status is returned if the resource is
      # valid and a 422 error response in case of validation errors. After it is
      # successfully submitted, the Payer Authorisation can no longer be edited.
      # Example URL: /payer_authorisations/:identity/actions/submit
      #
      # @param identity       # Unique identifier, beginning with "PA".
      # @param options [Hash] parameters as a hash, under a params key.
      def submit(identity, options = {})
        path = sub_url('/payer_authorisations/:identity/actions/submit', 'identity' => identity)

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

        Resources::PayerAuthorisation.new(unenvelope_body(response.body), response)
      end

      # Confirms the Payer Authorisation, indicating that the resources are ready to
      # be created.
      # A Payer Authorisation cannot be confirmed if it hasn't been submitted yet.
      #
      # <p class="notice">
      #   The main use of the confirm endpoint is to enable integrators to acknowledge
      # the end of the setup process.
      #   They might want to make the payers go through some other steps after they go
      # through our flow or make them go through the necessary verification mechanism
      # (upcoming feature).
      # </p>
      # Example URL: /payer_authorisations/:identity/actions/confirm
      #
      # @param identity       # Unique identifier, beginning with "PA".
      # @param options [Hash] parameters as a hash, under a params key.
      def confirm(identity, options = {})
        path = sub_url('/payer_authorisations/:identity/actions/confirm', 'identity' => identity)

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

        Resources::PayerAuthorisation.new(unenvelope_body(response.body), response)
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
        'payer_authorisations'
      end
    end
  end
end
