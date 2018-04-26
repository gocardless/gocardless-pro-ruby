# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a mandate_import_entry resource returned from the API

    # Mandate Import Entries are added to a [Mandate
    # Import](#core-endpoints-mandate-imports).
    # Each entry corresponds to one mandate to be imported into GoCardless.
    #
    # To import a mandate you will need:
    # <ol>
    #   <li>Identifying information about the customer (name/company and
    # address)</li>
    #   <li>Bank account details, consisting of an account holder name and
    #      either an IBAN or <a href="#appendix-local-bank-details">local bank
    # details</a></li>
    #   <li>Amendment details (SEPA only)</li>
    # </ol>
    #
    # We suggest you provide a `record_identifier` (which is unique within the
    # context of a
    # single mandate import) to help you to identify mandates that have been
    # created once the
    # import has been processed by GoCardless. You can
    # [list the mandate import
    # entries](#mandate-import-entries-list-all-mandate-import-entries),
    # match them up in your system using the `record_identifier`, and look at
    # the `links`
    # fields to find the mandate, customer and customer bank account that have
    # been imported.
    #
    # <p class="restricted-notice"><strong>Restricted</strong>: This API is
    # currently
    # only available for approved partners - please <a
    # href="mailto:help@gocardless.com">get
    # in touch</a> if you would like to use this API.</p>
    #
    class MandateImportEntry
      attr_reader :created_at
      attr_reader :record_identifier

      # Initialize a mandate_import_entry resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @created_at = object['created_at']
        @links = object['links']
        @record_identifier = object['record_identifier']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @mandate_import_entry_links ||= Links.new(@links)
      end

      # Provides the mandate_import_entry resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def customer
          @links['customer']
        end

        def customer_bank_account
          @links['customer_bank_account']
        end

        def mandate
          @links['mandate']
        end

        def mandate_import
          @links['mandate_import']
        end
      end
    end
  end
end
