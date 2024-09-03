#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a instalment_schedule resource returned from the API

    # Instalment schedules are objects which represent a collection of related
    # payments, with the
    # intention to collect the `total_amount` specified. The API supports both
    # schedule-based
    # creation (similar to subscriptions) as well as explicit selection of
    # differing payment
    # amounts and charge dates.
    #
    # Unlike subscriptions, the payments are created immediately, so the
    # instalment schedule
    # cannot be modified once submitted and instead can only be cancelled (which
    # will cancel
    # any of the payments which have not yet been submitted).
    #
    # Customers will receive a single notification about the complete schedule
    # of collection.
    #
    class InstalmentSchedule
      attr_reader :created_at, :currency, :id, :metadata, :name, :payment_errors, :status, :total_amount

      # Initialize a instalment_schedule resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @created_at = object['created_at']
        @currency = object['currency']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
        @name = object['name']
        @payment_errors = object['payment_errors']
        @status = object['status']
        @total_amount = object['total_amount']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @instalment_schedule_links ||= Links.new(@links)
      end

      # Provides the instalment_schedule resource as a hash of all its readable attributes
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

        def mandate
          @links['mandate']
        end

        def payments
          @links['payments']
        end
      end
    end
  end
end
