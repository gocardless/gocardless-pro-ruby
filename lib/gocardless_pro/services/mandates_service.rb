require_relative './base_service'
require 'uri'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Mandate endpoints
    class MandatesService < BaseService
      # Creates a new mandate object.
      # Example URL: /mandates
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/mandates'

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

        Resources::Mandate.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # mandates.
      # Example URL: /mandates
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/mandates'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Mandate
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

      # Retrieves the details of an existing mandate.
      # Example URL: /mandates/:identity
      #
      # @param identity       # Unique identifier, beginning with "MD".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/mandates/:identity', 'identity' => identity)

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::Mandate.new(unenvelope_body(response.body), response)
      end

      # Updates a mandate object. This accepts only the metadata parameter.
      # Example URL: /mandates/:identity
      #
      # @param identity       # Unique identifier, beginning with "MD".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/mandates/:identity', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::Mandate.new(unenvelope_body(response.body), response)
      end

      # Immediately cancels a mandate and all associated cancellable payments. Any
      # metadata supplied to this endpoint will be stored on the mandate cancellation
      # event it causes.
      #
      # This will fail with a `cancellation_failed` error if the
      # mandate is already cancelled.
      # Example URL: /mandates/:identity/actions/cancel
      #
      # @param identity       # Unique identifier, beginning with "MD".
      # @param options [Hash] parameters as a hash, under a params key.
      def cancel(identity, options = {})
        path = sub_url('/mandates/:identity/actions/cancel', 'identity' => identity)

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

        Resources::Mandate.new(unenvelope_body(response.body), response)
      end

      # <a name="mandate_not_inactive"></a>Reinstates a cancelled or expired mandate
      # to the banks. You will receive a `resubmission_requested` webhook, but after
      # that reinstating the mandate follows the same process as its initial creation,
      # so you will receive a `submitted` webhook, followed by a `reinstated` or
      # `failed` webhook up to two working days later. Any metadata supplied to this
      # endpoint will be stored on the `resubmission_requested` event it causes.
      #
      #
      # This will fail with a `mandate_not_inactive` error if the mandate is already
      # being submitted, or is active.
      #
      # Mandates can be resubmitted up to 3 times.
      # Example URL: /mandates/:identity/actions/reinstate
      #
      # @param identity       # Unique identifier, beginning with "MD".
      # @param options [Hash] parameters as a hash, under a params key.
      def reinstate(identity, options = {})
        path = sub_url('/mandates/:identity/actions/reinstate', 'identity' => identity)

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

        Resources::Mandate.new(unenvelope_body(response.body), response)
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
        'mandates'
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
