#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a currency_exchange_rate resource returned from the API

    # Currency exchange rates from our foreign exchange provider.
    class CurrencyExchangeRate
      attr_reader :rate, :source, :target, :time

      # Initialize a currency_exchange_rate resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @rate = object['rate']
        @source = object['source']
        @target = object['target']
        @time = object['time']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the currency_exchange_rate resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
