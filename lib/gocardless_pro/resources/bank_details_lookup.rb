#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a bank_details_lookup resource returned from the API

    # Look up the name and reachability of a bank account.
    class BankDetailsLookup
      attr_reader :available_debit_schemes, :bank_name, :bic

      # Initialize a bank_details_lookup resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @available_debit_schemes = object['available_debit_schemes']
        @bank_name = object['bank_name']
        @bic = object['bic']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the bank_details_lookup resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
