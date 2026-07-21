#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a outbound_payment_import_entry resource returned from the API

    # Import Entries are the individual rows of an outbound payment import,
    # representing each payment to be created.
    class OutboundPaymentImportEntry
      attr_reader :amount
      attr_reader :created_at
      attr_reader :id
      attr_reader :metadata
      attr_reader :processed_at
      attr_reader :reference
      attr_reader :scheme
      attr_reader :validation_errors
      attr_reader :verification_result

      # Initialize a outbound_payment_import_entry resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @created_at = object['created_at']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
        @processed_at = object['processed_at']
        @reference = object['reference']
        @scheme = object['scheme']
        @validation_errors = object['validation_errors']
        @verification_result = object['verification_result']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @outbound_payment_import_entry_links ||= Links.new(@links)
      end

      # Provides the outbound_payment_import_entry resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def outbound_payment
          @links['outbound_payment']
        end

        def outbound_payment_import
          @links['outbound_payment_import']
        end

        def recipient_bank_account
          @links['recipient_bank_account']
        end
      end
    end
  end
end
