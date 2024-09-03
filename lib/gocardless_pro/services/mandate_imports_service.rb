require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the MandateImport endpoints
    class MandateImportsService < BaseService
      # Mandate imports are first created, before mandates are added one-at-a-time, so
      # this endpoint merely signals the start of the import process. Once you've
      # finished
      # adding entries to an import, you should
      # [submit](#mandate-imports-submit-a-mandate-import) it.
      # Example URL: /mandate_imports
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/mandate_imports'

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

        Resources::MandateImport.new(unenvelope_body(response.body), response)
      end

      # Returns a single mandate import.
      # Example URL: /mandate_imports/:identity
      #
      # @param identity       # Unique identifier, beginning with "IM".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/mandate_imports/:identity', {
                         'identity' => identity
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::MandateImport.new(unenvelope_body(response.body), response)
      end

      # Submits the mandate import, which allows it to be processed by a member of the
      # GoCardless team. Once the import has been submitted, it can no longer have
      # entries
      # added to it.
      #
      # In our sandbox environment, to aid development, we automatically process
      # mandate
      # imports approximately 10 seconds after they are submitted. This will allow you
      # to
      # test both the "submitted" response and wait for the webhook to confirm the
      # processing has begun.
      # Example URL: /mandate_imports/:identity/actions/submit
      #
      # @param identity       # Unique identifier, beginning with "IM".
      # @param options [Hash] parameters as a hash, under a params key.
      def submit(identity, options = {})
        path = sub_url('/mandate_imports/:identity/actions/submit', {
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

        Resources::MandateImport.new(unenvelope_body(response.body), response)
      end

      # Cancels the mandate import, which aborts the import process and stops the
      # mandates
      # being set up in GoCardless. Once the import has been cancelled, it can no
      # longer have
      # entries added to it. Mandate imports which have already been submitted or
      # processed
      # cannot be cancelled.
      # Example URL: /mandate_imports/:identity/actions/cancel
      #
      # @param identity       # Unique identifier, beginning with "IM".
      # @param options [Hash] parameters as a hash, under a params key.
      def cancel(identity, options = {})
        path = sub_url('/mandate_imports/:identity/actions/cancel', {
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

        Resources::MandateImport.new(unenvelope_body(response.body), response)
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
        'mandate_imports'
      end
    end
  end
end
