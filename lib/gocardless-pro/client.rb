module GoCardless
  # A class for working with and talking to the GoCardless API
  class Client
    extend Forwardable

    # Access to the service for creditor to make API calls
    def creditors
      @creditors ||= Services::CreditorService.new(@api_service)
    end

    # Access to the service for creditor_bank_account to make API calls
    def creditor_bank_accounts
      @creditor_bank_accounts ||= Services::CreditorBankAccountService.new(@api_service)
    end

    # Access to the service for customer to make API calls
    def customers
      @customers ||= Services::CustomerService.new(@api_service)
    end

    # Access to the service for customer_bank_account to make API calls
    def customer_bank_accounts
      @customer_bank_accounts ||= Services::CustomerBankAccountService.new(@api_service)
    end

    # Access to the service for event to make API calls
    def events
      @events ||= Services::EventService.new(@api_service)
    end

    # Access to the service for helper to make API calls
    def helpers
      @helpers ||= Services::HelperService.new(@api_service)
    end

    # Access to the service for mandate to make API calls
    def mandates
      @mandates ||= Services::MandateService.new(@api_service)
    end

    # Access to the service for payment to make API calls
    def payments
      @payments ||= Services::PaymentService.new(@api_service)
    end

    # Access to the service for payout to make API calls
    def payouts
      @payouts ||= Services::PayoutService.new(@api_service)
    end

    # Access to the service for redirect_flow to make API calls
    def redirect_flows
      @redirect_flows ||= Services::RedirectFlowService.new(@api_service)
    end

    # Access to the service for refund to make API calls
    def refunds
      @refunds ||= Services::RefundService.new(@api_service)
    end

    # Access to the service for subscription to make API calls
    def subscriptions
      @subscriptions ||= Services::SubscriptionService.new(@api_service)
    end

    # Get a Client configured to use HTTP Basic authentication with the GC Api
    #
    # @param options [Hash<Symbol,String>] configuration for creating the client
    # @option options [Symbol] :environment the environment to connect to - one of `:live` or `:sandbox`.
    # @option options [Symbol] :token the API token
    # @option options [Symbol] :url the full URL used to make requests to. If you specify this, it will be used over the `environment` option.
    # @return [Client] A client configured to use the API with HTTP Basic
    #   authentication.
    #
    def initialize(options)
      access_token = options.delete(:token) || fail('No Access Token given to GoCardless Client')
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
        fail "Unknown environment key: #{environment}"
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
          'GoCardless-Version' => '2014-11-03',
          'User-Agent' => "#{user_agent}",
          'Content-Type' => 'application/json'
        }
      }
    end

    def user_agent
      @user_agent ||=
        begin
          gem_name = 'gocardless-pro'
          gem_info = "#{gem_name}"
          gem_info += "/v#{ GoCardless::VERSION}" if defined?(GoCardless::VERSION)
          ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
          ruby_version = RUBY_VERSION
          ruby_version += " p#{RUBY_PATCHLEVEL}" if defined?(RUBY_PATCHLEVEL)
          comment = ["#{ruby_engine} #{ruby_version}"]
          comment << "gocardless-pro v#{ GoCardless::VERSION}"
          comment << "faraday v#{Faraday::VERSION}"
          comment << RUBY_PLATFORM if defined?(RUBY_PLATFORM)
          "#{gem_info} (#{comment.join('; ')})"
        end
    end
  end
end
