

# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank
#
require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Refund objects represent (partial) refunds of a
    # [payment](#core-endpoints-payment) back to the
    # [customer](#core-endpoints-customers).
    #
    # GoCardless will notify you
    # via a [webhook](#webhooks) whenever a refund is created, and will update the
    # `amount_refunded` property of the payment.
    #
    # _Note:_ A payment that
    # has been (partially) refunded can still receive a late failure or chargeback
    # from the banks.
    # Represents an instance of a refund resource returned from the API
    class Refund
      attr_reader :amount

      attr_reader :created_at

      attr_reader :currency

      attr_reader :id

      attr_reader :metadata

      attr_reader :reference
      # initialize a resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @amount = object['amount']
        @created_at = object['created_at']
        @currency = object['currency']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
        @reference = object['reference']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # return the links that the resource has
      def links
        valid_link_keys = %w(payment )
        valid_links = @links.select { |key, _| valid_link_keys.include?(key) }

        links_class = Struct.new(
          *{

            payment: ''

          }.keys
        ) do
          def initialize(hash)
            hash.each do |key, val|
              send("#{key}=", val)
            end
          end
        end
        links_class.new(valid_links)
      end

      # Provides the resource as a hash of all it's readable attributes
      def to_h
        @object
      end
    end
  end
end
