#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a bank_account_holder_verification resource returned from the API

    # Create a bank account holder verification for a bank account.
    class BankAccountHolderVerification
      attr_reader :actual_account_name
      attr_reader :id
      attr_reader :result
      attr_reader :status
      attr_reader :type

      # Initialize a bank_account_holder_verification resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @actual_account_name = object['actual_account_name']
        @id = object['id']
        @result = object['result']
        @status = object['status']
        @type = object['type']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the bank_account_holder_verification resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
