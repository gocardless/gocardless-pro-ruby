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
      attr_reader :authorisation_source, :consent_parameters, :consent_type, :created_at, :funds_settlement, :id,
                  :metadata, :next_possible_charge_date, :next_possible_standard_ach_charge_date, :payments_require_approval, :reference, :scheme, :status, :verified_at

      # Initialize a mandate resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @authorisation_source = object['authorisation_source']
        @consent_parameters = object['consent_parameters']
        @consent_type = object['consent_type']
        @created_at = object['created_at']
        @funds_settlement = object['funds_settlement']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
        @next_possible_charge_date = object['next_possible_charge_date']
        @next_possible_standard_ach_charge_date = object['next_possible_standard_ach_charge_date']
        @payments_require_approval = object['payments_require_approval']
        @reference = object['reference']
        @scheme = object['scheme']
        @status = object['status']
        @verified_at = object['verified_at']
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
