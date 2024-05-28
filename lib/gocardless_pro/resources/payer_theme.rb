#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a payer_theme resource returned from the API

    # Custom colour themes for payment pages and customer notifications.
    class PayerTheme
      attr_reader :id

      # Initialize a payer_theme resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @id = object['id']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the payer_theme resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
