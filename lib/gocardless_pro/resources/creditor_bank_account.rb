#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a creditor_bank_account resource returned from the API

    # Creditor Bank Accounts hold the bank details of a
    # [creditor](#core-endpoints-creditors). These are the bank accounts which
    # your [payouts](#core-endpoints-payouts) will be sent to.
    #
    # Note that creditor bank accounts must be unique, and so you will encounter
    # a `bank_account_exists` error if you try to create a duplicate bank
    # account. You may wish to handle this by updating the existing record
    # instead, the ID of which will be provided as
    # `links[creditor_bank_account]` in the error response.
    #
    # <p class="restricted-notice"><strong>Restricted</strong>: This API is not
    # available for partner integrations.</p>
    class CreditorBankAccount
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

      # Initialize a creditor_bank_account resource instance
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
        @creditor_bank_account_links ||= Links.new(@links)
      end

      # Provides the creditor_bank_account resource as a hash of all its readable attributes
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
