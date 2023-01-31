#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a webhook resource returned from the API

    # Basic description of a webhook
    class Webhook
      attr_reader :created_at
      attr_reader :id
      attr_reader :is_test
      attr_reader :request_body
      attr_reader :request_headers
      attr_reader :response_body
      attr_reader :response_body_truncated
      attr_reader :response_code
      attr_reader :response_headers
      attr_reader :response_headers_content_truncated
      attr_reader :response_headers_count_truncated
      attr_reader :successful
      attr_reader :url

      # Initialize a webhook resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @created_at = object['created_at']
        @id = object['id']
        @is_test = object['is_test']
        @request_body = object['request_body']
        @request_headers = object['request_headers']
        @response_body = object['response_body']
        @response_body_truncated = object['response_body_truncated']
        @response_code = object['response_code']
        @response_headers = object['response_headers']
        @response_headers_content_truncated = object['response_headers_content_truncated']
        @response_headers_count_truncated = object['response_headers_count_truncated']
        @successful = object['successful']
        @url = object['url']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the webhook resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
