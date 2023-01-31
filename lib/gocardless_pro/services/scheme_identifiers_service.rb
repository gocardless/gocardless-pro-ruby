require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the SchemeIdentifier endpoints
    class SchemeIdentifiersService < BaseService
      # Creates a new scheme identifier. The scheme identifier must be [applied to a
      # creditor](#creditors-apply-a-scheme-identifier) before payments are taken
      # using it. The scheme identifier must also have the `status` of active before
      # it can be used. For some schemes e.g. faster_payments this will happen
      # instantly. For other schemes e.g. bacs this can take several days.
      #
      # Example URL: /scheme_identifiers
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/scheme_identifiers'

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

        Resources::SchemeIdentifier.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your scheme
      # identifiers.
      # Example URL: /scheme_identifiers
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/scheme_identifiers'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::SchemeIdentifier
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

      # Retrieves the details of an existing scheme identifier.
      # Example URL: /scheme_identifiers/:identity
      #
      # @param identity       # Unique identifier, usually beginning with "SU".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/scheme_identifiers/:identity', {
                         'identity' => identity,
                       })

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::SchemeIdentifier.new(unenvelope_body(response.body), response)
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
        'scheme_identifiers'
      end
    end
  end
end
