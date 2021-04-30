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
require_relative 'gocardless_pro/error/permission_error'
require_relative 'gocardless_pro/error/authentication_error'
require_relative 'gocardless_pro/error/rate_limit_error'
require_relative 'gocardless_pro/paginator'
require_relative 'gocardless_pro/request'
require_relative 'gocardless_pro/response'
require_relative 'gocardless_pro/api_response'
require_relative 'gocardless_pro/webhook'

require_relative 'gocardless_pro/resources/bank_authorisation'
require_relative 'gocardless_pro/services/bank_authorisations_service'

require_relative 'gocardless_pro/resources/bank_details_lookup'
require_relative 'gocardless_pro/services/bank_details_lookups_service'

require_relative 'gocardless_pro/resources/billing_request'
require_relative 'gocardless_pro/services/billing_requests_service'

require_relative 'gocardless_pro/resources/billing_request_flow'
require_relative 'gocardless_pro/services/billing_request_flows_service'

require_relative 'gocardless_pro/resources/creditor'
require_relative 'gocardless_pro/services/creditors_service'

require_relative 'gocardless_pro/resources/creditor_bank_account'
require_relative 'gocardless_pro/services/creditor_bank_accounts_service'

require_relative 'gocardless_pro/resources/currency_exchange_rate'
require_relative 'gocardless_pro/services/currency_exchange_rates_service'

require_relative 'gocardless_pro/resources/customer'
require_relative 'gocardless_pro/services/customers_service'

require_relative 'gocardless_pro/resources/customer_bank_account'
require_relative 'gocardless_pro/services/customer_bank_accounts_service'

require_relative 'gocardless_pro/resources/customer_notification'
require_relative 'gocardless_pro/services/customer_notifications_service'

require_relative 'gocardless_pro/resources/event'
require_relative 'gocardless_pro/services/events_service'

require_relative 'gocardless_pro/resources/instalment_schedule'
require_relative 'gocardless_pro/services/instalment_schedules_service'

require_relative 'gocardless_pro/resources/institution'
require_relative 'gocardless_pro/services/institutions_service'

require_relative 'gocardless_pro/resources/mandate'
require_relative 'gocardless_pro/services/mandates_service'

require_relative 'gocardless_pro/resources/mandate_import'
require_relative 'gocardless_pro/services/mandate_imports_service'

require_relative 'gocardless_pro/resources/mandate_import_entry'
require_relative 'gocardless_pro/services/mandate_import_entries_service'

require_relative 'gocardless_pro/resources/mandate_pdf'
require_relative 'gocardless_pro/services/mandate_pdfs_service'

require_relative 'gocardless_pro/resources/payer_authorisation'
require_relative 'gocardless_pro/services/payer_authorisations_service'

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

require_relative 'gocardless_pro/resources/scenario_simulator'
require_relative 'gocardless_pro/services/scenario_simulators_service'

require_relative 'gocardless_pro/resources/subscription'
require_relative 'gocardless_pro/services/subscriptions_service'

require_relative 'gocardless_pro/resources/tax_rate'
require_relative 'gocardless_pro/services/tax_rates_service'

require_relative 'gocardless_pro/resources/webhook'
require_relative 'gocardless_pro/services/webhooks_service'

require_relative 'gocardless_pro/client.rb'
