# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a payment resource returned from the API

    # Payment objects represent payments from a
    # [customer](#core-endpoints-customers) to a
    # [creditor](#whitelabel-partner-endpoints-creditors), taken against a
    # Direct Debit [mandate](#core-endpoints-mandates).
    #
    # GoCardless
    # will notify you via a [webhook](#appendix-webhooks) whenever the state of
    # a payment changes.
    class Payment
      attr_reader :amount
      attr_reader :amount_refunded
      attr_reader :charge_date
      attr_reader :created_at
      attr_reader :currency
      attr_reader :description
      attr_reader :id
      attr_reader :metadata
      attr_reader :reference
      attr_reader :status

      # Initialize a payment resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @amount_refunded = object['amount_refunded']
        @charge_date = object['charge_date']
        @created_at = object['created_at']
        @currency = object['currency']
        @description = object['description']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
        @reference = object['reference']
        @status = object['status']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @links_links ||= Links.new(@links)
      end

      # Provides the payment resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links
        end

        def creditor
          @links['creditor']
        end

        def mandate
          @links['mandate']
        end

        def payout
          @links['payout']
        end

        def subscription
          @links['subscription']
        end
      end
    end
  end
end
