#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a negative_balance_limit resource returned from the API

    # The negative balance limit is a threshold for the creditor balance beyond
    # which refunds are not permitted. The default limit is zero — refunds are
    # not permitted if the creditor has a negative balance. The limit can be
    # changed on a per-creditor basis.
    #
    class NegativeBalanceLimit
      attr_reader :balance_limit
      attr_reader :created_at
      attr_reader :currency
      attr_reader :id
      attr_reader :updated_at

      # Initialize a negative_balance_limit resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @balance_limit = object['balance_limit']
        @created_at = object['created_at']
        @currency = object['currency']
        @id = object['id']
        @links = object['links']
        @updated_at = object['updated_at']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @negative_balance_limit_links ||= Links.new(@links)
      end

      # Provides the negative_balance_limit resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def creator_user
          @links['creator_user']
        end

        def creditor
          @links['creditor']
        end
      end
    end
  end
end
