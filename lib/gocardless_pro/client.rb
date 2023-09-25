module GoCardlessPro
  # A class for working with and talking to the GoCardless API
  class Client
    extend Forwardable

    # Access to the service for bank_authorisation to make API calls
    def bank_authorisations
      @bank_authorisations ||= Services::BankAuthorisationsService.new(@api_service)
    end

    # Access to the service for bank_details_lookup to make API calls
    def bank_details_lookups
      @bank_details_lookups ||= Services::BankDetailsLookupsService.new(@api_service)
    end

    # Access to the service for billing_request to make API calls
    def billing_requests
      @billing_requests ||= Services::BillingRequestsService.new(@api_service)
    end

    # Access to the service for billing_request_flow to make API calls
    def billing_request_flows
      @billing_request_flows ||= Services::BillingRequestFlowsService.new(@api_service)
    end

    # Access to the service for billing_request_template to make API calls
    def billing_request_templates
      @billing_request_templates ||= Services::BillingRequestTemplatesService.new(@api_service)
    end

    # Access to the service for block to make API calls
    def blocks
      @blocks ||= Services::BlocksService.new(@api_service)
    end

    # Access to the service for creditor to make API calls
    def creditors
      @creditors ||= Services::CreditorsService.new(@api_service)
    end

    # Access to the service for creditor_bank_account to make API calls
    def creditor_bank_accounts
      @creditor_bank_accounts ||= Services::CreditorBankAccountsService.new(@api_service)
    end

    # Access to the service for currency_exchange_rate to make API calls
    def currency_exchange_rates
      @currency_exchange_rates ||= Services::CurrencyExchangeRatesService.new(@api_service)
    end

    # Access to the service for customer to make API calls
    def customers
      @customers ||= Services::CustomersService.new(@api_service)
    end

    # Access to the service for customer_bank_account to make API calls
    def customer_bank_accounts
      @customer_bank_accounts ||= Services::CustomerBankAccountsService.new(@api_service)
    end

    # Access to the service for customer_notification to make API calls
    def customer_notifications
      @customer_notifications ||= Services::CustomerNotificationsService.new(@api_service)
    end

    # Access to the service for event to make API calls
    def events
      @events ||= Services::EventsService.new(@api_service)
    end

    # Access to the service for instalment_schedule to make API calls
    def instalment_schedules
      @instalment_schedules ||= Services::InstalmentSchedulesService.new(@api_service)
    end

    # Access to the service for institution to make API calls
    def institutions
      @institutions ||= Services::InstitutionsService.new(@api_service)
    end

    # Access to the service for mandate to make API calls
    def mandates
      @mandates ||= Services::MandatesService.new(@api_service)
    end

    # Access to the service for mandate_import to make API calls
    def mandate_imports
      @mandate_imports ||= Services::MandateImportsService.new(@api_service)
    end

    # Access to the service for mandate_import_entry to make API calls
    def mandate_import_entries
      @mandate_import_entries ||= Services::MandateImportEntriesService.new(@api_service)
    end

    # Access to the service for mandate_pdf to make API calls
    def mandate_pdfs
      @mandate_pdfs ||= Services::MandatePdfsService.new(@api_service)
    end

    # Access to the service for negative_balance_limit to make API calls
    def negative_balance_limits
      @negative_balance_limits ||= Services::NegativeBalanceLimitsService.new(@api_service)
    end

    # Access to the service for payer_authorisation to make API calls
    def payer_authorisations
      @payer_authorisations ||= Services::PayerAuthorisationsService.new(@api_service)
    end

    # Access to the service for payment to make API calls
    def payments
      @payments ||= Services::PaymentsService.new(@api_service)
    end

    # Access to the service for payout to make API calls
    def payouts
      @payouts ||= Services::PayoutsService.new(@api_service)
    end

    # Access to the service for payout_item to make API calls
    def payout_items
      @payout_items ||= Services::PayoutItemsService.new(@api_service)
    end

    # Access to the service for redirect_flow to make API calls
    def redirect_flows
      @redirect_flows ||= Services::RedirectFlowsService.new(@api_service)
    end

    # Access to the service for refund to make API calls
    def refunds
      @refunds ||= Services::RefundsService.new(@api_service)
    end

    # Access to the service for scenario_simulator to make API calls
    def scenario_simulators
      @scenario_simulators ||= Services::ScenarioSimulatorsService.new(@api_service)
    end

    # Access to the service for scheme_identifier to make API calls
    def scheme_identifiers
      @scheme_identifiers ||= Services::SchemeIdentifiersService.new(@api_service)
    end

    # Access to the service for subscription to make API calls
    def subscriptions
      @subscriptions ||= Services::SubscriptionsService.new(@api_service)
    end

    # Access to the service for tax_rate to make API calls
    def tax_rates
      @tax_rates ||= Services::TaxRatesService.new(@api_service)
    end

    # Access to the service for verification_detail to make API calls
    def verification_details
      @verification_details ||= Services::VerificationDetailsService.new(@api_service)
    end

    # Access to the service for webhook to make API calls
    def webhooks
      @webhooks ||= Services::WebhooksService.new(@api_service)
    end

    # Get a Client configured to use HTTP Basic authentication with the GC Api
    #
    # @param options [Hash<Symbol,String>] configuration for creating the client
    # @option options [Symbol] :environment the environment to connect to - one of `:live` or `:sandbox`.
    # @option options [Symbol] :access_token the API token
    # @option options [Symbol] :url the full URL used to make requests to. If you specify this, it will be used over the `environment` option.
    # @option options [Symbol] :connection_options `Faraday` connection options hash, e.g. `{ request: { timeout: 3 } }`.
    # @return [Client] A client configured to use the API with HTTP Basic
    #   authentication.
    #
    def initialize(options)
      access_token = options.delete(:access_token) || raise('No Access Token given to GoCardless Client')
      environment = options.delete(:environment) || :live
      url = options.delete(:url) || url_for_environment(environment)
      options = custom_options(options)
      @api_service = ApiService.new(url, access_token, options)
    end

    private

    def url_for_environment(environment)
      if environment === :live
        'https://api.gocardless.com'
      elsif environment === :sandbox
        'https://api-sandbox.gocardless.com'
      else
        raise "Unknown environment key: #{environment}"
      end
    end

    # Get customized options.
    def custom_options(options)
      return default_options if options.nil?

      return default_options.merge(options) unless options[:default_headers]

      opts = default_options.merge(options)
      opts[:default_headers] = default_options[:default_headers].merge(options[:default_headers])

      opts
    end

    # Get the default options.
    def default_options
      {
        default_headers: {
          'GoCardless-Version' => '2015-07-06',
          'User-Agent' => "#{user_agent}",
          'Content-Type' => 'application/json',
          'GoCardless-Client-Library' => 'gocardless-pro-ruby',
          'GoCardless-Client-Version' => '2.49.0',
        },
      }
    end

    def user_agent
      @user_agent ||=
        begin
          gem_info = 'gocardless-pro-ruby'
          gem_info += "/v#{GoCardlessPro::VERSION}" if defined?(GoCardlessPro::VERSION)

          ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'

          ruby_version = RUBY_VERSION
          ruby_version += "p#{RUBY_PATCHLEVEL}" if defined?(RUBY_PATCHLEVEL)

          interpreter_version = defined?(JRUBY_VERSION) ? JRUBY_VERSION : RUBY_VERSION

          comment = [
            "#{ruby_engine}/#{ruby_version}",
            "#{RUBY_ENGINE}/#{interpreter_version}",
            "#{RUBY_PLATFORM}",
          ]
          comment << "faraday/#{Faraday::VERSION}"
          "#{gem_info} #{comment.join(' ')}"
        end
    end
  end
end
