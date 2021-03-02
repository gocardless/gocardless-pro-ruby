# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a payer_authorisation resource returned from the API

    # Payer Authorisation resource acts as a wrapper for creating customer, bank
    # account and mandate details in a single request.
    # PayerAuthorisation API enables the integrators to build their own custom
    # payment pages.
    #
    # The process to use the Payer Authorisation API is as follows:
    #
    #   1. Create a Payer Authorisation, either empty or with already available
    # information
    #   2. Update the authorisation with additional information or fix any
    # mistakes
    #   3. Submit the authorisation, after the payer has reviewed their
    # information
    #   4. [coming soon] Redirect the payer to the verification mechanisms from
    # the response of the Submit request (this will be introduced as a
    # non-breaking change)
    #   5. Confirm the authorisation to indicate that the resources can be
    # created
    #
    # After the Payer Authorisation is confirmed, resources will eventually be
    # created as it's an asynchronous process.
    #
    # To retrieve the status and ID of the linked resources you can do one of
    # the following:
    # <ol>
    #   <li> Listen to <code>  payer_authorisation_completed </code>  <a
    # href="#appendix-webhooks"> webhook</a> (recommended)</li>
    #   <li> Poll the GET <a
    # href="#payer-authorisations-get-a-single-payer-authorisation">
    # endpoint</a></li>
    #   <li> Poll the GET events API
    # <code>https://api.gocardless.com/events?payer_authorisation={id}&action=completed</code>
    # </li>
    # </ol>
    #
    # <p class="notice">
    #   Note that the `create` and `update` endpoints behave differently than
    #   other existing `create` and `update` endpoints. The Payer Authorisation
    # is still saved if incomplete data is provided.
    #   We return the list of incomplete data in the `incomplete_fields` along
    # with the resources in the body of the response.
    #   The bank account details(account_number, bank_code & branch_code) must
    # be sent together rather than splitting across different request for both
    # `create` and `update` endpoints.
    #   <br><br>
    #   The API is designed to be flexible and allows you to collect information
    # in multiple steps without storing any sensitive data in the browser or in
    # your servers.
    # </p>
    class PayerAuthorisation
      attr_reader :bank_account
      attr_reader :created_at
      attr_reader :customer
      attr_reader :id
      attr_reader :incomplete_fields
      attr_reader :mandate
      attr_reader :status

      # Initialize a payer_authorisation resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @bank_account = object['bank_account']
        @created_at = object['created_at']
        @customer = object['customer']
        @id = object['id']
        @incomplete_fields = object['incomplete_fields']
        @links = object['links']
        @mandate = object['mandate']
        @status = object['status']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @payer_authorisation_links ||= Links.new(@links)
      end

      # Provides the payer_authorisation resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def bank_account
          @links['bank_account']
        end

        def customer
          @links['customer']
        end

        def mandate
          @links['mandate']
        end
      end
    end
  end
end
