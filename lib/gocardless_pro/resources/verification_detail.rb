#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a verification_detail resource returned from the API

    # Verification details represent any information needed by GoCardless to
    # verify a creditor.
    #
    # <p class="restricted-notice"><strong>Restricted</strong>:
    #   These endpoints are restricted to customers who want to collect their
    # merchant's
    #   verification details and pass them to GoCardless via our API. Please
    # [get in
    #   touch](mailto:help@gocardless.com) if you wish to enable this feature on
    # your
    #   account.</p>
    class VerificationDetail
      attr_reader :address_line1, :address_line2, :address_line3, :city, :company_number, :description, :directors,
                  :name, :postal_code

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
