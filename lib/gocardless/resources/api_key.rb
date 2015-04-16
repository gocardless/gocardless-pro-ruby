

# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank
#
require 'uri'

module GoCardless
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # <a name="api_key_not_active"></a>API keys are designed to be used by any
    # integrations you build. You should generate a key and then use it to make
    # requests to the API and set the webhook URL for that integration. They do
    # not expire, but can be disabled.
    # Represents an instance of a api_key resource returned from the API
    class ApiKey
      attr_reader :created_at

      attr_reader :enabled

      attr_reader :id

      attr_reader :key

      attr_reader :name

      attr_reader :webhook_url
      # initialize a resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object)
        @object = object

        @created_at = object['created_at']
        @enabled = object['enabled']
        @id = object['id']
        @key = object['key']
        @links = object['links']
        @name = object['name']
        @webhook_url = object['webhook_url']
      end

      # return the links that the resource has
      def links
        Struct.new(
          *{

            role: ''

          }.keys.sort
        ).new(*@links.sort.map(&:last))
      end
    end
  end
end