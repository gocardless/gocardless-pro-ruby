# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a billing_request_flow resource returned from the API

    # Billing Request Flows can be created to enable a payer to authorise a
    # payment created for a scheme with strong payer
    # authorisation (such as open banking single payments).
    class BillingRequestFlow
      attr_reader :authorisation_url
      attr_reader :auto_fulfil
      attr_reader :created_at
      attr_reader :expires_at
      attr_reader :id
      attr_reader :lock_bank_account_details
      attr_reader :lock_customer_details
      attr_reader :redirect_uri
      attr_reader :session_token

      # Initialize a billing_request_flow resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @authorisation_url = object['authorisation_url']
        @auto_fulfil = object['auto_fulfil']
        @created_at = object['created_at']
        @expires_at = object['expires_at']
        @id = object['id']
        @links = object['links']
        @lock_bank_account_details = object['lock_bank_account_details']
        @lock_customer_details = object['lock_customer_details']
        @redirect_uri = object['redirect_uri']
        @session_token = object['session_token']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @billing_request_flow_links ||= Links.new(@links)
      end

      # Provides the billing_request_flow resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def billing_request
          @links['billing_request']
        end
      end
    end
  end
end
