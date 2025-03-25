#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a balance resource returned from the API

    # Returns the balances for a creditor. These balances are the same as what’s
    # shown in the dashboard with one exception (mentioned below under
    # balance_type).
    #
    # These balances will typically be 3-5 minutes old. The balance amounts
    # likely won’t match what’s shown in the dashboard as the dashboard balances
    # are updated much less frequently (once per day).
    class Balance
      attr_reader :amount, :balance_type, :currency, :last_updated_at

      # Initialize a balance resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @balance_type = object['balance_type']
        @currency = object['currency']
        @last_updated_at = object['last_updated_at']
        @links = object['links']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @balance_links ||= Links.new(@links)
      end

      # Provides the balance resource as a hash of all its readable attributes
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
