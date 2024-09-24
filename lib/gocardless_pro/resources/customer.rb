#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a customer resource returned from the API

    # Customer objects hold the contact details for a customer. A customer can
    # have several [customer bank
    # accounts](#core-endpoints-customer-bank-accounts), which in turn can have
    # several Direct Debit [mandates](#core-endpoints-mandates).
    class Customer
      attr_reader :address_line1, :address_line2, :address_line3, :city, :company_name, :country_code, :created_at,
                  :danish_identity_number, :email, :family_name, :given_name, :id, :language, :metadata, :phone_number, :postal_code, :region, :swedish_identity_number

      # Initialize a customer resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @address_line1 = object['address_line1']
        @address_line2 = object['address_line2']
        @address_line3 = object['address_line3']
        @city = object['city']
        @company_name = object['company_name']
        @country_code = object['country_code']
        @created_at = object['created_at']
        @danish_identity_number = object['danish_identity_number']
        @email = object['email']
        @family_name = object['family_name']
        @given_name = object['given_name']
        @id = object['id']
        @language = object['language']
        @metadata = object['metadata']
        @phone_number = object['phone_number']
        @postal_code = object['postal_code']
        @region = object['region']
        @swedish_identity_number = object['swedish_identity_number']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the customer resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
