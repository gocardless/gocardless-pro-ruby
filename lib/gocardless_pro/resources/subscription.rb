#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a subscription resource returned from the API

    # Subscriptions create [payments](#core-endpoints-payments) according to a
    # schedule.
    #
    # ### Recurrence Rules
    #
    # The following rules apply when specifying recurrence:
    #
    # - If `day_of_month` and `start_date` are not provided `start_date` will be
    # the [mandate](#core-endpoints-mandates)'s `next_possible_charge_date` and
    # the subscription will then recur based on the `interval` & `interval_unit`
    # - If `month` or `day_of_month` are present the following validations
    # apply:
    #
    # | __interval_unit__ | __month__                                      |
    # __day_of_month__                           |
    # | :---------------- | :--------------------------------------------- |
    # :----------------------------------------- |
    # | yearly            | optional (required if `day_of_month` provided) |
    # optional (invalid if `month` not provided) |
    # | monthly           | invalid                                        |
    # optional                                   |
    # | weekly            | invalid                                        |
    # invalid                                    |
    #
    # Examples:
    #
    # | __interval_unit__ | __interval__ | __month__ | __day_of_month__ | valid?
    #                                             |
    # | :---------------- | :----------- | :-------- | :--------------- |
    # :------------------------------------------------- |
    # | yearly            | 1            | january   | -1               | valid
    #                                             |
    # | monthly           | 6            |           |                  | valid
    #                                             |
    # | monthly           | 6            |           | 12               | valid
    #                                             |
    # | weekly            | 2            |           |                  | valid
    #                                             |
    # | yearly            | 1            | march     |                  |
    # invalid - missing `day_of_month`                   |
    # | yearly            | 1            |           | 2                |
    # invalid - missing `month`                          |
    # | monthly           | 6            | august    | 12               |
    # invalid - `month` must be blank                    |
    # | weekly            | 2            | october   | 10               |
    # invalid - `month` and `day_of_month` must be blank |
    #
    # ### Rolling dates
    #
    # When a charge date falls on a non-business day, one of two things will
    # happen:
    #
    # - if the recurrence rule specified `-1` as the `day_of_month`, the charge
    # date will be rolled __backwards__ to the previous business day (i.e., the
    # last working day of the month).
    # - otherwise the charge date will be rolled __forwards__ to the next
    # business day.
    class Subscription
      attr_reader :amount
      attr_reader :app_fee
      attr_reader :count
      attr_reader :created_at
      attr_reader :currency
      attr_reader :day_of_month
      attr_reader :earliest_charge_date_after_resume
      attr_reader :end_date
      attr_reader :id
      attr_reader :interval
      attr_reader :interval_unit
      attr_reader :metadata
      attr_reader :month
      attr_reader :name
      attr_reader :payment_reference
      attr_reader :retry_if_possible
      attr_reader :start_date
      attr_reader :status
      attr_reader :upcoming_payments

      # Initialize a subscription resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @app_fee = object['app_fee']
        @count = object['count']
        @created_at = object['created_at']
        @currency = object['currency']
        @day_of_month = object['day_of_month']
        @earliest_charge_date_after_resume = object['earliest_charge_date_after_resume']
        @end_date = object['end_date']
        @id = object['id']
        @interval = object['interval']
        @interval_unit = object['interval_unit']
        @links = object['links']
        @metadata = object['metadata']
        @month = object['month']
        @name = object['name']
        @payment_reference = object['payment_reference']
        @retry_if_possible = object['retry_if_possible']
        @start_date = object['start_date']
        @status = object['status']
        @upcoming_payments = object['upcoming_payments']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @subscription_links ||= Links.new(@links)
      end

      # Provides the subscription resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def mandate
          @links['mandate']
        end
      end
    end
  end
end
