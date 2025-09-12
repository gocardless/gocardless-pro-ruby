#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a export resource returned from the API

    # File-based exports of data
    class Export
      attr_reader :created_at
      attr_reader :currency
      attr_reader :download_url
      attr_reader :export_type
      attr_reader :id

      # Initialize a export resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @created_at = object['created_at']
        @currency = object['currency']
        @download_url = object['download_url']
        @export_type = object['export_type']
        @id = object['id']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the export resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
