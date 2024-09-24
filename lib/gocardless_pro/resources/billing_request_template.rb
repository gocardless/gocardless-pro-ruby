#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a billing_request_template resource returned from the API

    # Billing Request Templates are reusable templates that result in
    # numerous Billing Requests with similar attributes. They provide
    # a no-code solution for generating various types of multi-user payment
    # links.
    #
    # Each template includes a reusable URL that can be embedded in a website
    # or shared with customers via email. Every time the URL is opened,
    # it generates a new Billing Request.
    #
    # Billing Request Templates overcome the key limitation of the Billing
    # Request:
    # a Billing Request cannot be shared among multiple users because it is
    # intended
    # for single-use and is designed to cater to the unique needs of individual
    # customers.
    class BillingRequestTemplate
      attr_reader :authorisation_url, :created_at, :id, :mandate_request_currency, :mandate_request_description,
                  :mandate_request_metadata, :mandate_request_scheme, :mandate_request_verify, :metadata, :name, :payment_request_amount, :payment_request_currency, :payment_request_description, :payment_request_metadata, :payment_request_scheme, :redirect_uri, :updated_at

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
