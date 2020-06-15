require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the MandateImportEntry endpoints
    class MandateImportEntriesService < BaseService
      # For an existing [mandate import](#core-endpoints-mandate-imports), this
      # endpoint can
      # be used to add individual mandates to be imported into GoCardless.
      #
      # You can add no more than 30,000 rows to a single mandate import.
      # If you attempt to go over this limit, the API will return a
      # `record_limit_exceeded` error.
      # Example URL: /mandate_import_entries
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/mandate_import_entries'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params

        options[:retry_failures] = true

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::MandateImportEntry.new(unenvelope_body(response.body), response)
      end

      # For an existing mandate import, this endpoint lists all of the entries
      # attached.
      #
      # After a mandate import has been submitted, you can use this endpoint to
      # associate records
      # in your system (using the `record_identifier` that you provided when creating
      # the
      # mandate import).
      #
      # Example URL: /mandate_import_entries
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/mandate_import_entries'

        options[:retry_failures] = true

        response = make_request(:get, path, options)

        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::MandateImportEntry
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

      private

      # Unenvelope the response of the body using the service's `envelope_key`
      #
      # @param body [Hash]
      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      # return the key which API responses will envelope data under
      def envelope_key
        'mandate_import_entries'
      end
    end
  end
end
