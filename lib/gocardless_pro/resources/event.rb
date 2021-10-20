# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a event resource returned from the API

    # Events are stored for all webhooks. An event refers to a resource which
    # has been updated, for example a payment which has been collected, or a
    # mandate which has been transferred. See [here](#event-actions) for a
    # complete list of event types.
    class Event
      attr_reader :action
      attr_reader :created_at
      attr_reader :customer_notifications
      attr_reader :details
      attr_reader :id
      attr_reader :metadata
      attr_reader :resource_type

      # Initialize a event resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @action = object['action']
        @created_at = object['created_at']
        @customer_notifications = object['customer_notifications']
        @details = object['details']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
        @resource_type = object['resource_type']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @event_links ||= Links.new(@links)
      end

      # Provides the event resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def bank_authorisation
          @links['bank_authorisation']
        end

        def billing_request
          @links['billing_request']
        end

        def billing_request_flow
          @links['billing_request_flow']
        end

        def creditor
          @links['creditor']
        end

        def customer
          @links['customer']
        end

        def customer_bank_account
          @links['customer_bank_account']
        end

        def instalment_schedule
          @links['instalment_schedule']
        end

        def mandate
          @links['mandate']
        end

        def mandate_request_mandate
          @links['mandate_request_mandate']
        end

        def new_customer_bank_account
          @links['new_customer_bank_account']
        end

        def new_mandate
          @links['new_mandate']
        end

        def organisation
          @links['organisation']
        end

        def parent_event
          @links['parent_event']
        end

        def payer_authorisation
          @links['payer_authorisation']
        end

        def payment
          @links['payment']
        end

        def payment_request_payment
          @links['payment_request_payment']
        end

        def payout
          @links['payout']
        end

        def previous_customer_bank_account
          @links['previous_customer_bank_account']
        end

        def refund
          @links['refund']
        end

        def subscription
          @links['subscription']
        end
      end
    end
  end
end
