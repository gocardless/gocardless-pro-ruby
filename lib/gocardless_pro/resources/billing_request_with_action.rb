#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a billing_request_with_action resource returned from the API

    #  Billing Requests help create resources that require input or action from
    # a customer. An example of required input might be additional customer
    # billing details, while an action would be asking a customer to authorise a
    # payment using their mobile banking app.
    #
    # See [Billing Requests:
    # Overview](https://developer.gocardless.com/getting-started/billing-requests/overview/)
    # for how-to's, explanations and tutorials.
    class BillingRequestWithAction
      attr_reader :bank_authorisations, :billing_requests

      # Initialize a billing_request_with_action resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @bank_authorisations = object['bank_authorisations']
        @billing_requests = object['billing_requests']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the billing_request_with_action resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
