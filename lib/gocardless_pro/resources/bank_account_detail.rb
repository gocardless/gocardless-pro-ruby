#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a bank_account_detail resource returned from the API

    # Retrieve bank account details in JWE encrypted format
    class BankAccountDetail
      attr_reader :ciphertext, :encrypted_key, :iv, :protected, :tag

      # Initialize a bank_account_detail resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @ciphertext = object['ciphertext']
        @encrypted_key = object['encrypted_key']
        @iv = object['iv']
        @protected = object['protected']
        @tag = object['tag']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the bank_account_detail resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
