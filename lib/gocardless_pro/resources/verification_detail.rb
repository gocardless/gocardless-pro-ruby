#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a verification_detail resource returned from the API

    # Details of a creditor that are required for verification
    class VerificationDetail
      attr_reader :address_line1
      attr_reader :address_line2
      attr_reader :address_line3
      attr_reader :city
      attr_reader :company_number
      attr_reader :description
      attr_reader :directors
      attr_reader :name
      attr_reader :postal_code

      # Initialize a verification_detail resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @address_line1 = object['address_line1']
        @address_line2 = object['address_line2']
        @address_line3 = object['address_line3']
        @city = object['city']
        @company_number = object['company_number']
        @description = object['description']
        @directors = object['directors']
        @links = object['links']
        @name = object['name']
        @postal_code = object['postal_code']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @verification_detail_links ||= Links.new(@links)
      end

      # Provides the verification_detail resource as a hash of all its readable attributes
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
