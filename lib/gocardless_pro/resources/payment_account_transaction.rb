#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a payment_account_transaction resource returned from the API

    #  Payment account transactions represent movements of funds on a given
    #  payment account. The payment account is provisioned by GoCardless and is
    #  used to fund [outbound payments](#core-endpoints-outbound-payments).
    class PaymentAccountTransaction
      attr_reader :amount
      attr_reader :balance_after_transaction
      attr_reader :counterparty_name
      attr_reader :currency
      attr_reader :description
      attr_reader :direction
      attr_reader :id
      attr_reader :reference
      attr_reader :value_date

      # Initialize a payment_account_transaction resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @balance_after_transaction = object['balance_after_transaction']
        @counterparty_name = object['counterparty_name']
        @currency = object['currency']
        @description = object['description']
        @direction = object['direction']
        @id = object['id']
        @links = object['links']
        @reference = object['reference']
        @value_date = object['value_date']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @payment_account_transaction_links ||= Links.new(@links)
      end

      # Provides the payment_account_transaction resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def outbound_payment
          @links['outbound_payment']
        end

        def payment_bank_account
          @links['payment_bank_account']
        end

        def payout
          @links['payout']
        end
      end
    end
  end
end
