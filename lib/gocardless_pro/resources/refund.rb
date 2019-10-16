# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a refund resource returned from the API

    # Refund objects represent (partial) refunds of a
    # [payment](#core-endpoints-payments) back to the
    # [customer](#core-endpoints-customers).
    #
    # GoCardless will notify you via a [webhook](#appendix-webhooks) whenever a
    # refund is created, and will update the `amount_refunded` property of the
    # payment.
    class Refund
      attr_reader :amount
      attr_reader :created_at
      attr_reader :currency
      attr_reader :fx
      attr_reader :id
      attr_reader :metadata
      attr_reader :reference

      # Initialize a refund resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @created_at = object['created_at']
        @currency = object['currency']
        @fx = object['fx']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
        @reference = object['reference']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @refund_links ||= Links.new(@links)
      end

      # Provides the refund resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def mandate
          @links['mandate']
        end

        def payment
          @links['payment']
        end
      end
    end
  end
end
