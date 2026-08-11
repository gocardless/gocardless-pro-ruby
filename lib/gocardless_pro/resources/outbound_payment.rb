#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a outbound_payment resource returned from the API

    # Outbound Payments represent payments sent from creditors
    # (https://developer.gocardless.com/api-reference/#core-endpoints-creditors).
    #
    # GoCardless will notify you via a webhook
    # (https://developer.gocardless.com/api-reference/#appendix-webhooks) when
    # the status of the outbound payment changes
    # (https://developer.gocardless.com/api-reference/#event-types-outbound-payment).
    #
    # Rate limiting
    #
    # Two rate limits apply to the Outbound Payments APIs:
    #
    # - All POST Outbound Payment endpoints (create, withdraw, approve, cancel
    # and etc.) share a single rate-limit group of 300 requests per minute. As
    # initiating a payment typically requires two API calls (one to create the
    # payment and one to approve it), this allows you to add approximately 150
    # outbound payments per minute.
    # - All remaining Outbound Payment endpoints are limited to 500 requests per
    # minute.
    class OutboundPayment
      attr_reader :amount
      attr_reader :created_at
      attr_reader :currency
      attr_reader :description
      attr_reader :execution_date
      attr_reader :id
      attr_reader :is_withdrawal
      attr_reader :metadata
      attr_reader :reference
      attr_reader :scheme
      attr_reader :status
      attr_reader :verifications

      # Initialize a outbound_payment resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @created_at = object['created_at']
        @currency = object['currency']
        @description = object['description']
        @execution_date = object['execution_date']
        @id = object['id']
        @is_withdrawal = object['is_withdrawal']
        @links = object['links']
        @metadata = object['metadata']
        @reference = object['reference']
        @scheme = object['scheme']
        @status = object['status']
        @verifications = object['verifications']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @outbound_payment_links ||= Links.new(@links)
      end

      # Provides the outbound_payment resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def creditor
          @links['creditor']
        end

        def customer
          @links['customer']
        end

        def outbound_payment_import
          @links['outbound_payment_import']
        end

        def recipient_bank_account
          @links['recipient_bank_account']
        end
      end
    end
  end
end
