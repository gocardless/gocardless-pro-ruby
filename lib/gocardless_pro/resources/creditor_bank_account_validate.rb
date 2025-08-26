#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a creditor_bank_account_validate resource returned from the API

    # Creditor Bank Accounts hold the bank details of a
    # [creditor](#core-endpoints-creditors). These are the bank accounts which
    # your [payouts](#core-endpoints-payouts) will be sent to.
    #
    # When all locale details and Iban are supplied validates creditor bank
    # details without creating a creditor bank account and also provdes bank
    # details such as name and icon url. When partial details are are provided
    # the endpoint will only provide bank details such as name and icon url but
    # will not be able to determine if the provided details are valid.
    #
    # <p class="restricted-notice"><strong>Restricted</strong>: This API is not
    # available for partner integrations.</p>
    class CreditorBankAccountValidate
      attr_reader :bank_name, :icon_url, :invalid_reasons, :is_valid

      # Initialize a creditor_bank_account_validate resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @bank_name = object['bank_name']
        @icon_url = object['icon_url']
        @invalid_reasons = object['invalid_reasons']
        @is_valid = object['is_valid']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the creditor_bank_account_validate resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
