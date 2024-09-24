#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a mandate_pdf resource returned from the API

    # Mandate PDFs allow you to easily display [scheme-rules
    # compliant](#appendix-compliance-requirements) Direct Debit mandates to
    # your customers.
    class MandatePdf
      attr_reader :expires_at, :url

      # Initialize a mandate_pdf resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @expires_at = object['expires_at']
        @url = object['url']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the mandate_pdf resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
