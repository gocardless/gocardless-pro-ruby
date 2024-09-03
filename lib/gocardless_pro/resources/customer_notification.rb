#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a customer_notification resource returned from the API

    # Customer Notifications represent the notification which is due to be sent
    # to a customer
    # after an event has happened. The event, the resource and the customer to
    # be notified
    # are all identified in the `links` property.
    #
    # Note that these are ephemeral records - once the notification has been
    # actioned in some
    # way, it is no longer visible using this API.
    #
    # <p class="restricted-notice"><strong>Restricted</strong>: This API is
    # currently only available for approved integrators - please <a
    # href="mailto:help@gocardless.com">get in touch</a> if you would like to
    # use this API.</p>
    class CustomerNotification
      attr_reader :action_taken, :action_taken_at, :action_taken_by, :id, :type

      # Initialize a customer_notification resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @action_taken = object['action_taken']
        @action_taken_at = object['action_taken_at']
        @action_taken_by = object['action_taken_by']
        @id = object['id']
        @links = object['links']
        @type = object['type']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @customer_notification_links ||= Links.new(@links)
      end

      # Provides the customer_notification resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def customer
          @links['customer']
        end

        def event
          @links['event']
        end

        def mandate
          @links['mandate']
        end

        def payment
          @links['payment']
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
