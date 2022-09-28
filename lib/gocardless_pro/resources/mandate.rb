# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a mandate resource returned from the API

    # Mandates represent the Direct Debit mandate with a
    # [customer](#core-endpoints-customers).
    #
    # GoCardless will notify you via a [webhook](#appendix-webhooks) whenever
    # the status of a mandate changes.
    class Mandate
      attr_reader :created_at
      attr_reader :id
      attr_reader :metadata
      attr_reader :next_possible_charge_date
      attr_reader :payments_require_approval
      attr_reader :reference
      attr_reader :scheme
      attr_reader :status

      # Initialize a mandate resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @created_at = object['created_at']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
        @next_possible_charge_date = object['next_possible_charge_date']
        @payments_require_approval = object['payments_require_approval']
        @reference = object['reference']
        @scheme = object['scheme']
        @status = object['status']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @mandate_links ||= Links.new(@links)
      end

      # Provides the mandate resource as a hash of all its readable attributes
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

        def customer
          @links['customer']
        end

        def customer_bank_account
          @links['customer_bank_account']
        end

        def new_mandate
          @links['new_mandate']
        end
      end
    end
  end
end
