#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a billing_request_template resource returned from the API

    # Billing Request Templates
    class BillingRequestTemplate
      attr_reader :authorisation_url
      attr_reader :created_at
      attr_reader :id
      attr_reader :mandate_request_currency
      attr_reader :mandate_request_description
      attr_reader :mandate_request_metadata
      attr_reader :mandate_request_scheme
      attr_reader :mandate_request_verify
      attr_reader :metadata
      attr_reader :name
      attr_reader :payment_request_amount
      attr_reader :payment_request_currency
      attr_reader :payment_request_description
      attr_reader :payment_request_metadata
      attr_reader :payment_request_scheme
      attr_reader :redirect_uri
      attr_reader :updated_at

      # Initialize a billing_request_template resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @authorisation_url = object['authorisation_url']
        @created_at = object['created_at']
        @id = object['id']
        @mandate_request_currency = object['mandate_request_currency']
        @mandate_request_description = object['mandate_request_description']
        @mandate_request_metadata = object['mandate_request_metadata']
        @mandate_request_scheme = object['mandate_request_scheme']
        @mandate_request_verify = object['mandate_request_verify']
        @metadata = object['metadata']
        @name = object['name']
        @payment_request_amount = object['payment_request_amount']
        @payment_request_currency = object['payment_request_currency']
        @payment_request_description = object['payment_request_description']
        @payment_request_metadata = object['payment_request_metadata']
        @payment_request_scheme = object['payment_request_scheme']
        @redirect_uri = object['redirect_uri']
        @updated_at = object['updated_at']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the billing_request_template resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
