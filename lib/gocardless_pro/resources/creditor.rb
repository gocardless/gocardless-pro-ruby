#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a creditor resource returned from the API

    # Each [payment](#core-endpoints-payments) taken through the API is linked
    # to a "creditor", to whom the payment is then paid out. In most cases your
    # organisation will have a single "creditor", but the API also supports
    # collecting payments on behalf of others.
    #
    # Currently, for Anti Money Laundering reasons, any creditors you add must
    # be directly related to your organisation.
    class Creditor
      attr_reader :address_line1, :address_line2, :address_line3, :bank_reference_prefix, :can_create_refunds, :city,
                  :country_code, :created_at, :creditor_type, :custom_payment_pages_enabled, :fx_payout_currency, :id, :logo_url, :mandate_imports_enabled, :merchant_responsible_for_notifications, :name, :postal_code, :region, :scheme_identifiers, :verification_status

      # Initialize a creditor resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @address_line1 = object['address_line1']
        @address_line2 = object['address_line2']
        @address_line3 = object['address_line3']
        @bank_reference_prefix = object['bank_reference_prefix']
        @can_create_refunds = object['can_create_refunds']
        @city = object['city']
        @country_code = object['country_code']
        @created_at = object['created_at']
        @creditor_type = object['creditor_type']
        @custom_payment_pages_enabled = object['custom_payment_pages_enabled']
        @fx_payout_currency = object['fx_payout_currency']
        @id = object['id']
        @links = object['links']
        @logo_url = object['logo_url']
        @mandate_imports_enabled = object['mandate_imports_enabled']
        @merchant_responsible_for_notifications = object['merchant_responsible_for_notifications']
        @name = object['name']
        @postal_code = object['postal_code']
        @region = object['region']
        @scheme_identifiers = object['scheme_identifiers']
        @verification_status = object['verification_status']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Return the links that the resource has
      def links
        @creditor_links ||= Links.new(@links)
      end

      # Provides the creditor resource as a hash of all its readable attributes
      def to_h
        @object
      end

      class Links
        def initialize(links)
          @links = links || {}
        end

        def default_aud_payout_account
          @links['default_aud_payout_account']
        end

        def default_cad_payout_account
          @links['default_cad_payout_account']
        end

        def default_dkk_payout_account
          @links['default_dkk_payout_account']
        end

        def default_eur_payout_account
          @links['default_eur_payout_account']
        end

        def default_gbp_payout_account
          @links['default_gbp_payout_account']
        end

        def default_nzd_payout_account
          @links['default_nzd_payout_account']
        end

        def default_sek_payout_account
          @links['default_sek_payout_account']
        end

        def default_usd_payout_account
          @links['default_usd_payout_account']
        end
      end
    end
  end
end
