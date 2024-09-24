#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a scheme_identifier resource returned from the API

    # This represents a scheme identifier (e.g. a SUN in Bacs or a CID in SEPA).
    # Scheme identifiers are used to specify the beneficiary name that appears
    # on customers' bank statements.
    #
    class SchemeIdentifier
      attr_reader :address_line1, :address_line2, :address_line3, :can_specify_mandate_reference, :city, :country_code,
                  :created_at, :currency, :email, :id, :minimum_advance_notice, :name, :phone_number, :postal_code, :reference, :region, :scheme, :status

      # Initialize a scheme_identifier resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @address_line1 = object['address_line1']
        @address_line2 = object['address_line2']
        @address_line3 = object['address_line3']
        @can_specify_mandate_reference = object['can_specify_mandate_reference']
        @city = object['city']
        @country_code = object['country_code']
        @created_at = object['created_at']
        @currency = object['currency']
        @email = object['email']
        @id = object['id']
        @minimum_advance_notice = object['minimum_advance_notice']
        @name = object['name']
        @phone_number = object['phone_number']
        @postal_code = object['postal_code']
        @reference = object['reference']
        @region = object['region']
        @scheme = object['scheme']
        @status = object['status']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the scheme_identifier resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
