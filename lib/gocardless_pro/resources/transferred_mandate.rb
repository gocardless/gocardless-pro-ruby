#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a transferred_mandate resource returned from the API

    # Mandates that have been transferred using Current Account Switch Service
    class TransferredMandate
      attr_reader :encrypted_customer_bank_details, :encrypted_decryption_key, :public_key_id

      # Initialize a transferred_mandate resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @encrypted_customer_bank_details = object['encrypted_customer_bank_details']
        @encrypted_decryption_key = object['encrypted_decryption_key']
        @links = object['links']
        @public_key_id = object['public_key_id']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @transferred_mandate_links ||= Links.new(@links)
      end

      # Provides the transferred_mandate resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def customer_bank_account
          @links['customer_bank_account']
        end

        def mandate
          @links['mandate']
        end
      end
    end
  end
end
