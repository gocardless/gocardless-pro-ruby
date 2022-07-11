# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a customer_bank_account resource returned from the API

    # Customer Bank Accounts hold the bank details of a
    # [customer](#core-endpoints-customers). They always belong to a
    # [customer](#core-endpoints-customers), and may be linked to several Direct
    # Debit [mandates](#core-endpoints-mandates).
    #
    # Note that customer bank accounts must be unique, and so you will encounter
    # a `bank_account_exists` error if you try to create a duplicate bank
    # account. You may wish to handle this by updating the existing record
    # instead, the ID of which will be provided as
    # `links[customer_bank_account]` in the error response.
    #
    # _Note:_ To ensure the customer's bank accounts are valid, verify them
    # first
    # using
    #
    # [bank_details_lookups](#bank-details-lookups-perform-a-bank-details-lookup),
    # before proceeding with creating the accounts
    class CustomerBankAccount
      attr_reader :account_holder_name
      attr_reader :account_number_ending
      attr_reader :account_type
      attr_reader :bank_name
      attr_reader :country_code
      attr_reader :created_at
      attr_reader :currency
      attr_reader :enabled
      attr_reader :id
      attr_reader :metadata

      # Initialize a customer_bank_account resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @account_holder_name = object['account_holder_name']
        @account_number_ending = object['account_number_ending']
        @account_type = object['account_type']
        @bank_name = object['bank_name']
        @country_code = object['country_code']
        @created_at = object['created_at']
        @currency = object['currency']
        @enabled = object['enabled']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @customer_bank_account_links ||= Links.new(@links)
      end

      # Provides the customer_bank_account resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def customer
          @links['customer']
        end
      end
    end
  end
end
