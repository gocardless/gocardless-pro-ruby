# encoding: utf-8

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
    #
    # Notes:
    # - the `phone_number` field may only be supplied for New Zealand customers,
    # and must be supplied if you intend to set up an BECS NZ mandate with the
    # customer.
    # - the `swedish_identity_number` field may only be supplied for Swedish
    # customers, and must be supplied if you intend to set up an Autogiro
    # mandate with the customer.
    # - the `danish_identity_number` field may only be supplied for Danish
    # customers, and must be supplied if you intend to set up a Betalingsservice
    # mandate with the customer.
    class Customer
      attr_reader :address_line1
      attr_reader :address_line2
      attr_reader :address_line3
      attr_reader :city
      attr_reader :company_name
      attr_reader :country_code
      attr_reader :created_at
      attr_reader :danish_identity_number
      attr_reader :email
      attr_reader :family_name
      attr_reader :given_name
      attr_reader :id
      attr_reader :language
      attr_reader :metadata
      attr_reader :phone_number
      attr_reader :postal_code
      attr_reader :region
      attr_reader :swedish_identity_number

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
