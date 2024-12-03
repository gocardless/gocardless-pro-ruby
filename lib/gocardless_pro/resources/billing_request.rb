#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a billing_request resource returned from the API

    #  Billing Requests help create resources that require input or action from
    # a customer. An example of required input might be additional customer
    # billing details, while an action would be asking a customer to authorise a
    # payment using their mobile banking app.
    #
    # See [Billing Requests:
    # Overview](https://developer.gocardless.com/getting-started/billing-requests/overview/)
    # for how-to's, explanations and tutorials. <p
    # class="notice"><strong>Important</strong>: All properties associated with
    # `subscription_request` and `instalment_schedule_request` are only
    # supported for ACH and PAD schemes.</p>
    class BillingRequest
      attr_reader :actions, :created_at, :fallback_enabled, :fallback_occurred, :id, :instalment_schedule_request,
                  :mandate_request, :metadata, :payment_request, :purpose_code, :resources, :status, :subscription_request

      # Initialize a billing_request resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @actions = object['actions']
        @created_at = object['created_at']
        @fallback_enabled = object['fallback_enabled']
        @fallback_occurred = object['fallback_occurred']
        @id = object['id']
        @instalment_schedule_request = object['instalment_schedule_request']
        @links = object['links']
        @mandate_request = object['mandate_request']
        @metadata = object['metadata']
        @payment_request = object['payment_request']
        @purpose_code = object['purpose_code']
        @resources = object['resources']
        @status = object['status']
        @subscription_request = object['subscription_request']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @billing_request_links ||= Links.new(@links)
      end

      # Provides the billing_request resource as a hash of all its readable attributes
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

        def creditor
          @links['creditor']
        end

        def customer
          @links['customer']
        end

        def customer_bank_account
          @links['customer_bank_account']
        end

        def customer_billing_detail
          @links['customer_billing_detail']
        end

        def instalment_schedule_request
          @links['instalment_schedule_request']
        end

        def instalment_schedule_request_instalment_schedule
          @links['instalment_schedule_request_instalment_schedule']
        end

        def mandate_request
          @links['mandate_request']
        end

        def mandate_request_mandate
          @links['mandate_request_mandate']
        end

        def organisation
          @links['organisation']
        end

        def payment_provider
          @links['payment_provider']
        end

        def payment_request
          @links['payment_request']
        end

        def payment_request_payment
          @links['payment_request_payment']
        end

        def subscription_request
          @links['subscription_request']
        end

        def subscription_request_subscription
          @links['subscription_request_subscription']
        end
      end
    end
  end
end
