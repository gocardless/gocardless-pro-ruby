# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a block resource returned from the API

    # Blocks are created to prevent certain customer details from being used
    # when creating
    # mandates.
    #
    # The details used to create blocks can be exact matches, like a bank
    # account or an email,
    # or a more generic match such as an email domain. New block types may be
    # added over time.
    #
    # A block object is in essence a simple rule that is used to match against
    # details in a
    # newly created mandate. If there is a successful match then the mandate is
    # transitioned
    # to a "blocked" state.
    #
    # Payments and subscriptions cannot be created against a mandate in blocked
    # state.
    #
    # A mandate can never be transitioned out of the blocked state.
    #
    # <p class="notice">
    #   This API is currently only available for approved integrators - please
    # <a href="mailto:help@gocardless.com">get in touch</a> if you would like to
    # use this API.
    # </p>
    class Block
      attr_reader :active
      attr_reader :block_type
      attr_reader :created_at
      attr_reader :id
      attr_reader :reason_description
      attr_reader :reason_type
      attr_reader :resource_reference
      attr_reader :updated_at

      # Initialize a block resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @active = object['active']
        @block_type = object['block_type']
        @created_at = object['created_at']
        @id = object['id']
        @reason_description = object['reason_description']
        @reason_type = object['reason_type']
        @resource_reference = object['resource_reference']
        @updated_at = object['updated_at']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the block resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
