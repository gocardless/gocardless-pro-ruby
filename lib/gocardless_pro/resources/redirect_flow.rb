#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a redirect_flow resource returned from the API

    # <p class="deprecated-notice"><strong>Deprecated</strong>: Redirect Flows
    # are our legacy APIs for setting up
    # mandates and will no longer be supported in the future. We strongly
    # recommend using the
    # [Billing Request flow](#billing-requests) instead.</p>
    #
    # Redirect flows enable you to use GoCardless' [hosted payment
    # pages](https://pay-sandbox.gocardless.com/AL000000AKFPFF) to set up
    # mandates with your customers. These pages are fully compliant and have
    # been translated into Danish, Dutch, French, German, Italian, Norwegian,
    # Portuguese, Slovak, Spanish and Swedish.
    #
    # The overall flow is:
    #
    # 1. You [create](#redirect-flows-create-a-redirect-flow) a redirect flow
    # for your customer, and redirect them to the returned redirect url, e.g.
    # `https://pay.gocardless.com/flow/RE123`.
    #
    # 2. Your customer supplies their name, email, address, and bank account
    # details, and submits the form. This securely stores their details, and
    # redirects them back to your `success_redirect_url` with
    # `redirect_flow_id=RE123` in the querystring.
    #
    # 3. You [complete](#redirect-flows-complete-a-redirect-flow) the redirect
    # flow, which creates a [customer](#core-endpoints-customers), [customer
    # bank account](#core-endpoints-customer-bank-accounts), and
    # [mandate](#core-endpoints-mandates), and returns the ID of the mandate.
    # You may wish to create a [subscription](#core-endpoints-subscriptions) or
    # [payment](#core-endpoints-payments) at this point.
    #
    # Once you have [completed](#redirect-flows-complete-a-redirect-flow) the
    # redirect flow via the API, you should display a confirmation page to your
    # customer, confirming that their Direct Debit has been set up. You can
    # build your own page, or redirect to the one we provide in the
    # `confirmation_url` attribute of the redirect flow.
    #
    # Redirect flows expire 30 minutes after they are first created. You cannot
    # complete an expired redirect flow. For an integrator this is shorter and
    # they will expire after 10 minutes.
    class RedirectFlow
      attr_reader :confirmation_url
      attr_reader :created_at
      attr_reader :description
      attr_reader :id
      attr_reader :mandate_reference
      attr_reader :metadata
      attr_reader :redirect_url
      attr_reader :scheme
      attr_reader :session_token
      attr_reader :success_redirect_url

      # Initialize a redirect_flow resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @confirmation_url = object['confirmation_url']
        @created_at = object['created_at']
        @description = object['description']
        @id = object['id']
        @links = object['links']
        @mandate_reference = object['mandate_reference']
        @metadata = object['metadata']
        @redirect_url = object['redirect_url']
        @scheme = object['scheme']
        @session_token = object['session_token']
        @success_redirect_url = object['success_redirect_url']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @redirect_flow_links ||= Links.new(@links)
      end

      # Provides the redirect_flow resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def billing_request
          @links['billing_request']
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

        def mandate
          @links['mandate']
        end
      end
    end
  end
end
