# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'json'
require 'zlib'
require 'faraday'
require 'time'

require 'uri'

module GoCardlessPro
end

version_file = 'gocardless_pro/version'

if File.file? File.expand_path("#{version_file}.rb", File.dirname(__FILE__))
  require_relative version_file
else
  GoCardlessPro::VERSION = ''.freeze
end

require_relative 'gocardless_pro/api_service'
require_relative 'gocardless_pro/list_response'
require_relative 'gocardless_pro/middlewares/raise_gocardless_errors'
require_relative 'gocardless_pro/error'
require_relative 'gocardless_pro/error/validation_error'
require_relative 'gocardless_pro/error/gocardless_error'
require_relative 'gocardless_pro/error/invalid_api_usage_error'
require_relative 'gocardless_pro/error/invalid_state_error'
require_relative 'gocardless_pro/error/api_error'
require_relative 'gocardless_pro/paginator'
require_relative 'gocardless_pro/request'
require_relative 'gocardless_pro/response'
require_relative 'gocardless_pro/api_response'

require_relative 'gocardless_pro/resources/bank_details_lookup'
require_relative 'gocardless_pro/services/bank_details_lookups_service'

require_relative 'gocardless_pro/resources/creditor'
require_relative 'gocardless_pro/services/creditors_service'

require_relative 'gocardless_pro/resources/creditor_bank_account'
require_relative 'gocardless_pro/services/creditor_bank_accounts_service'

require_relative 'gocardless_pro/resources/customer'
require_relative 'gocardless_pro/services/customers_service'

require_relative 'gocardless_pro/resources/customer_bank_account'
require_relative 'gocardless_pro/services/customer_bank_accounts_service'

require_relative 'gocardless_pro/resources/event'
require_relative 'gocardless_pro/services/events_service'

require_relative 'gocardless_pro/resources/mandate'
require_relative 'gocardless_pro/services/mandates_service'

require_relative 'gocardless_pro/resources/mandate_pdf'
require_relative 'gocardless_pro/services/mandate_pdfs_service'

require_relative 'gocardless_pro/resources/payment'
require_relative 'gocardless_pro/services/payments_service'

require_relative 'gocardless_pro/resources/payout'
require_relative 'gocardless_pro/services/payouts_service'

require_relative 'gocardless_pro/resources/payout_item'
require_relative 'gocardless_pro/services/payout_items_service'

require_relative 'gocardless_pro/resources/redirect_flow'
require_relative 'gocardless_pro/services/redirect_flows_service'

require_relative 'gocardless_pro/resources/refund'
require_relative 'gocardless_pro/services/refunds_service'

require_relative 'gocardless_pro/resources/subscription'
require_relative 'gocardless_pro/services/subscriptions_service'

require_relative 'gocardless_pro/client.rb'
