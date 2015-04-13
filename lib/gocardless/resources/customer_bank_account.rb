

# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank
#
require 'uri'

module GoCardless
  module Resources
    # Customer Bank Accounts hold the bank details of a
    # [customer](https://developer.gocardless.com/pro/#api-endpoints-customers).
    # They always belong to a
    # [customer](https://developer.gocardless.com/pro/#api-endpoints-customers),
    # and may be linked to several Direct Debit
    # [mandates](https://developer.gocardless.com/pro/#api-endpoints-mandates).

    # #
    # Note that customer bank accounts must be unique, and so you will
    # encounter a `bank_account_exists` error if you try to create a duplicate
    # bank account. You may wish to handle this by updating the existing record
    # instead, the ID of which will be provided as links[customer_bank_account] in
    # the error response.
    class CustomerBankAccount
      attr_reader :account_holder_name

      attr_reader :account_number_ending

      attr_reader :bank_name

      attr_reader :country_code

      attr_reader :created_at

      attr_reader :currency

      attr_reader :enabled

      attr_reader :id

      attr_reader :metadata
      def initialize(object)
        @object = object

        @account_holder_name = object['account_holder_name']
        @account_number_ending = object['account_number_ending']
        @bank_name = object['bank_name']
        @country_code = object['country_code']
        @created_at = object['created_at']
        @currency = object['currency']
        @enabled = object['enabled']
        @id = object['id']
        @links = object['links']
        @metadata = object['metadata']
      end

      def links
        Struct.new(
          *{

            customer: ''

          }.keys
        ).new(*@links.values)
      end

      def envelope_key
        # TODO: could you use $propName here, or use the Envelope property
        'customer_bank_accounts'
      end
    end
  end
end
