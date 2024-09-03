#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a tax_rate resource returned from the API

    # Tax rates from tax authority.
    #
    # We also maintain a [static list of the tax rates for each
    # jurisdiction](#appendix-tax-rates).
    class TaxRate
      attr_reader :end_date, :id, :jurisdiction, :percentage, :start_date, :type

      # Initialize a tax_rate resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @end_date = object['end_date']
        @id = object['id']
        @jurisdiction = object['jurisdiction']
        @percentage = object['percentage']
        @start_date = object['start_date']
        @type = object['type']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the tax_rate resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
