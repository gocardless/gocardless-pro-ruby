# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a billing_request resource returned from the API

    # Billing Requests
    class BillingRequest
      attr_reader :actions
      attr_reader :auto_fulfil
      attr_reader :created_at
      attr_reader :id
      attr_reader :mandate_request
      attr_reader :metadata
      attr_reader :payment_request
      attr_reader :resources
      attr_reader :status

      # Initialize a billing_request resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @actions = object['actions']
        @auto_fulfil = object['auto_fulfil']
        @created_at = object['created_at']
        @id = object['id']
        @links = object['links']
        @mandate_request = object['mandate_request']
        @metadata = object['metadata']
        @payment_request = object['payment_request']
        @resources = object['resources']
        @status = object['status']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @billing_request_links ||= Links.new(@links)
      end

      # Provides the billing_request resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def bank_authorisation
          @links['bank_authorisation']
        end

        def customer
          @links['customer']
        end

        def customer_bank_account
          @links['customer_bank_account']
        end

        def customer_billing_detail
          @links['customer_billing_detail']
        end
      end
    end
  end
end
