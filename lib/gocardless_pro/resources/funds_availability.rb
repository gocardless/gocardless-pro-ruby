#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a funds_availability resource returned from the API

    # Checks if the payer's current balance is sufficient to cover the amount
    # the merchant wants to charge within the consent parameters defined on the
    # mandate.
    class FundsAvailability
      attr_reader :available

      # Initialize a funds_availability resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @available = object['available']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the funds_availability resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
