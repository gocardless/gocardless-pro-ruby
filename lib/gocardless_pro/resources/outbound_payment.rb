#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a outbound_payment resource returned from the API

    # Outbound Payments represent payments sent from
    # [creditors](#core-endpoints-creditors).
    #
    # GoCardless will notify you via a [webhook](#appendix-webhooks) when the
    # status of the outbound payment [changes](#event-actions-outbound-payment).
    #
    # <p class="restricted-notice"><strong>Restricted</strong>: Outbound
    # Payments are currently in Early Access and available only to a limited
    # list of organisations. If you are interested in using this feature, please
    # stay tuned for our public launch announcement. We are actively testing and
    # refining our API to ensure it meets your needs and provides the best
    # experience.</p>
    class OutboundPayment
      attr_reader :amount, :created_at, :currency, :description, :execution_date, :id, :is_withdrawal, :metadata,
                  :reference, :scheme, :status, :verifications

      # Initialize a outbound_payment resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @created_at = object['created_at']
        @currency = object['currency']
        @description = object['description']
        @execution_date = object['execution_date']
        @id = object['id']
        @is_withdrawal = object['is_withdrawal']
        @links = object['links']
        @metadata = object['metadata']
        @reference = object['reference']
        @scheme = object['scheme']
        @status = object['status']
        @verifications = object['verifications']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @outbound_payment_links ||= Links.new(@links)
      end

      # Provides the outbound_payment resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def creditor
          @links['creditor']
        end

        def customer
          @links['customer']
        end

        def recipient_bank_account
          @links['recipient_bank_account']
        end
      end
    end
  end
end
