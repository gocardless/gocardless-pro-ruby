#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a payment_account resource returned from the API

    # Access the details of bank accounts provided for you by GoCardless that
    # are used to fund [Outbound Payments](#core-endpoints-outbound-payments).
    class PaymentAccount
      attr_reader :account_balance
      attr_reader :account_holder_name
      attr_reader :account_number_ending
      attr_reader :bank_name
      attr_reader :currency
      attr_reader :id

      # Initialize a payment_account resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @account_balance = object['account_balance']
        @account_holder_name = object['account_holder_name']
        @account_number_ending = object['account_number_ending']
        @bank_name = object['bank_name']
        @currency = object['currency']
        @id = object['id']
        @links = object['links']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @payment_account_links ||= Links.new(@links)
      end

      # Provides the payment_account resource as a hash of all its readable attributes
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
      end
    end
  end
end
