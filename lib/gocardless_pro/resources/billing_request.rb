#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a billing_request resource returned from the API

    # Billing Requests help create resources that require input or action from a
    # customer. An example of required input might be additional customer
    # billing
    # details, while an action would be asking a customer to authorise a payment
    # using their mobile banking app.
    #
    # See [Billing Requests:
    # Overview](https://developer.gocardless.com/getting-started/billing-requests/overview/)
    # for how-to's, explanations and tutorials.
    class BillingRequest
      attr_reader :actions
      attr_reader :created_at
      attr_reader :fallback_enabled
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
        @created_at = object['created_at']
        @fallback_enabled = object['fallback_enabled']
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

        def creditor
          @links['creditor']
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

        def mandate_request
          @links['mandate_request']
        end

        def mandate_request_mandate
          @links['mandate_request_mandate']
        end

        def organisation
          @links['organisation']
        end

        def payment_request
          @links['payment_request']
        end

        def payment_request_payment
          @links['payment_request_payment']
        end
      end
    end
  end
end
