#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a bank_authorisation resource returned from the API

    # Bank Authorisations can be used to authorise Billing Requests.
    # Authorisations
    # are created against a specific bank, usually the bank that provides the
    # payer's
    # account.
    #
    # Creation of Bank Authorisations is only permitted from GoCardless hosted
    # UIs
    # (see Billing Request Flows) to ensure we meet regulatory requirements for
    # checkout flows.
    class BankAuthorisation
      attr_reader :authorisation_type
      attr_reader :authorised_at
      attr_reader :created_at
      attr_reader :expires_at
      attr_reader :id
      attr_reader :last_visited_at
      attr_reader :redirect_uri
      attr_reader :url

      # Initialize a bank_authorisation resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @authorisation_type = object['authorisation_type']
        @authorised_at = object['authorised_at']
        @created_at = object['created_at']
        @expires_at = object['expires_at']
        @id = object['id']
        @last_visited_at = object['last_visited_at']
        @links = object['links']
        @redirect_uri = object['redirect_uri']
        @url = object['url']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @bank_authorisation_links ||= Links.new(@links)
      end

      # Provides the bank_authorisation resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def billing_request
          @links['billing_request']
        end

        def institution
          @links['institution']
        end
      end
    end
  end
end
