#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a outbound_payment_import resource returned from the API

    # Outbound Payment Imports allow you to create multiple payments via a
    # single API call.
    #
    # The Workflow:
    #
    # 1. Create the outbound payment import.
    # 2. Retrieve an authorisation link from the response.
    # 3. Redirect the user to the link to authorise the import.
    # 4. Once the user authorises the import, the individual outbound payments
    # are automatically submitted.
    #
    # Import entries are not processed as actual payments until they are
    # reviewed and authorised in GoCardless Dashboard.
    # Upon approval, a unique outbound payment is generated for every entry in
    # the import.
    #
    # Outbound Payment Imports are capped at 1000 entries. If you expect to
    # exceed this limit, please create multiple smaller imports.
    class OutboundPaymentImport
      attr_reader :amount_sum
      attr_reader :authorisation_url
      attr_reader :created_at
      attr_reader :currency
      attr_reader :entry_counts
      attr_reader :id
      attr_reader :status

      # Initialize a outbound_payment_import resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount_sum = object['amount_sum']
        @authorisation_url = object['authorisation_url']
        @created_at = object['created_at']
        @currency = object['currency']
        @entry_counts = object['entry_counts']
        @id = object['id']
        @links = object['links']
        @status = object['status']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @outbound_payment_import_links ||= Links.new(@links)
      end

      # Provides the outbound_payment_import resource as a hash of all its readable attributes
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
