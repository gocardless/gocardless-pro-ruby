require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Block endpoints
    class BlocksService < BaseService
      # Creates a new Block of a given type. By default it will be active.
      # Example URL: /blocks
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/blocks'

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

        Resources::Block.new(unenvelope_body(response.body), response)
      end

      # Retrieves the details of an existing block.
      # Example URL: /blocks/:identity
      #
      # @param identity       # Unique identifier, beginning with "BLC".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/blocks/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::Block.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # blocks.
      # Example URL: /blocks
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/blocks'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Block
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

      # Disables a block so that it no longer will prevent mandate creation.
      # Example URL: /blocks/:identity/actions/disable
      #
      # @param identity       # Unique identifier, beginning with "BLC".
      # @param options [Hash] parameters as a hash, under a params key.
      def disable(identity, options = {})
        path = sub_url('/blocks/:identity/actions/disable', 'identity' => identity)

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

        Resources::Block.new(unenvelope_body(response.body), response)
      end

      # Enables a previously disabled block so that it will prevent mandate creation
      # Example URL: /blocks/:identity/actions/enable
      #
      # @param identity       # Unique identifier, beginning with "BLC".
      # @param options [Hash] parameters as a hash, under a params key.
      def enable(identity, options = {})
        path = sub_url('/blocks/:identity/actions/enable', 'identity' => identity)

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

        Resources::Block.new(unenvelope_body(response.body), response)
      end

      # Creates new blocks for a given reference. By default blocks will be active.
      # Returns 201 if at least one block was created. Returns 200 if there were no
      # new
      # blocks created.
      # Example URL: /blocks/block_by_ref
      # @param options [Hash] parameters as a hash, under a params key.
      def block_by_ref(options = {})
        path = '/blocks/block_by_ref'

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

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Block
        )
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
        'blocks'
      end
    end
  end
end
