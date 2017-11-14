# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a payout_item resource returned from the API

    # When we collect a payment on your behalf, we add the money you've
    # collected to your
    # GoCardless balance, minus any fees paid. Periodically (usually every
    # working day),
    # we take any positive balance in your GoCardless account, and pay it out to
    # your
    # nominated bank account.
    #
    # Other actions in your GoCardless account can also affect your balance. For
    # example,
    # if a customer charges back a payment, we'll deduct the payment's amount
    # from your
    # balance, but add any fees you paid for that payment back to your balance.
    #
    # The Payout Items API allows you to view, on a per-payout basis, the credit
    # and debit
    # items that make up that payout's amount.
    #
    # <p class="beta-notice"><strong>Beta</strong>:	The Payout Items API is in
    # beta, and is
    # subject to <a href="#overview-backwards-compatibility">backwards
    # incompatible changes</a>
    # with 30 days notice. Before making any breaking changes, we will contact
    # all integrators
    # who have used the API.</p>
    #
    class PayoutItem
      attr_reader :amount
      attr_reader :type

      # Initialize a payout_item resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @links = object['links']
        @type = object['type']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @payout_item_links ||= Links.new(@links)
      end

      # Provides the payout_item resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def payment
          @links['payment']
        end
      end
    end
  end
end
