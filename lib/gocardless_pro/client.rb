module GoCardlessPro
  # A class for working with and talking to the GoCardless API
  class Client
    extend Forwardable

    # Access to the service for bank_details_lookup to make API calls
    def bank_details_lookups
      @bank_details_lookups ||= Services::BankDetailsLookupsService.new(@api_service)
    end

    # Access to the service for creditor to make API calls
    def creditors
      @creditors ||= Services::CreditorsService.new(@api_service)
    end

    # Access to the service for creditor_bank_account to make API calls
    def creditor_bank_accounts
      @creditor_bank_accounts ||= Services::CreditorBankAccountsService.new(@api_service)
    end

    # Access to the service for customer to make API calls
    def customers
      @customers ||= Services::CustomersService.new(@api_service)
    end

    # Access to the service for customer_bank_account to make API calls
    def customer_bank_accounts
      @customer_bank_accounts ||= Services::CustomerBankAccountsService.new(@api_service)
    end

    # Access to the service for event to make API calls
    def events
      @events ||= Services::EventsService.new(@api_service)
    end

    # Access to the service for mandate to make API calls
    def mandates
      @mandates ||= Services::MandatesService.new(@api_service)
    end

    # Access to the service for mandate_pdf to make API calls
    def mandate_pdfs
      @mandate_pdfs ||= Services::MandatePdfsService.new(@api_service)
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

    # Access to the service for subscription to make API calls
    def subscriptions
      @subscriptions ||= Services::SubscriptionsService.new(@api_service)
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
          'User-Agent' => user_agent.to_s,
          'Content-Type' => 'application/json',
          'GoCardless-Client-Library' => 'gocardless-pro-ruby',
          'GoCardless-Client-Version' => '2.4.0',
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
            RUBY_PLATFORM.to_s,
          ]
          comment << "faraday/#{Faraday::VERSION}"
          "#{gem_info} #{comment.join(' ')}"
        end
    end
  end
end
