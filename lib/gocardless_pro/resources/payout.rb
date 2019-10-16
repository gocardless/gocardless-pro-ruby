# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a payout resource returned from the API

    # Payouts represent transfers from GoCardless to a
    # [creditor](#core-endpoints-creditors). Each payout contains the funds
    # collected from one or many [payments](#core-endpoints-payments). Payouts
    # are created automatically after a payment has been successfully collected.
    class Payout
      attr_reader :amount
      attr_reader :arrival_date
      attr_reader :created_at
      attr_reader :currency
      attr_reader :deducted_fees
      attr_reader :fx
      attr_reader :id
      attr_reader :payout_type
      attr_reader :reference
      attr_reader :status

      # Initialize a payout resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @arrival_date = object['arrival_date']
        @created_at = object['created_at']
        @currency = object['currency']
        @deducted_fees = object['deducted_fees']
        @fx = object['fx']
        @id = object['id']
        @links = object['links']
        @payout_type = object['payout_type']
        @reference = object['reference']
        @status = object['status']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @payout_links ||= Links.new(@links)
      end

      # Provides the payout resource as a hash of all its readable attributes
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

        def creditor_bank_account
          @links['creditor_bank_account']
        end
      end
    end
  end
end
