# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a mandate_request_constraints resource returned from the API

    # Constraints that will apply to the mandate_request. (Optional)
    # Specifically for PayTo and VRP.
    class MandateRequestConstraints
      attr_reader :end_date
      attr_reader :max_amount_per_payment
      attr_reader :periodic_limits
      attr_reader :start_date

      # Initialize a mandate_request_constraints resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @end_date = object['end_date']
        @max_amount_per_payment = object['max_amount_per_payment']
        @periodic_limits = object['periodic_limits']
        @start_date = object['start_date']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the mandate_request_constraints resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
