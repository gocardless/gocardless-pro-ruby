require 'securerandom'

module GoCardlessPro
  # A class that wraps an API request
  class Request
    MAX_RETRIES = 3
    RETRY_DELAY = 0.5
    RETRYABLE_EXCEPTIONS = [Faraday::TimeoutError,
                            Faraday::ConnectionFailed,
                            GoCardlessPro::ApiError,
                            GoCardlessPro::GoCardlessError].freeze

    # Initialize a request class, which makes calls to the API
    # @param connection
    # @param method [Symbol] the method to make the request with
    # @param path [String] the path to make the request to
    # @param options [hash] options for the request
    # @param headers [hash] headers to send with the request
    def initialize(connection, method, path, options)
      @connection = connection
      @method = method
      @path = path
      @headers = (options.delete(:headers) || {}).each_with_object({}) do |(k, v), hsh|
        hsh[k.to_s] = v
      end
      @envelope_name = options.delete(:envelope_key)
      @retry_failures = options.delete(:retry_failures) { true }
      @given_options = options

      @request_body = request_body

      if @request_body.is_a?(Hash)
        @request_body = @request_body.to_json
        @headers['Content-Type'] ||= 'application/json'
      end

      @headers['Idempotency-Key'] ||= SecureRandom.uuid if @method == :post
    end

    # Make the request and wrap it in a Response object
    def request
      if @retry_failures
        with_retries { Response.new(make_request) }
      else
        Response.new(make_request)
      end
    end

    def with_retries
      requests_attempted = 0
      total_requests_allowed = MAX_RETRIES

      begin
        yield
      rescue StandardError => e
        requests_attempted += 1

        raise e unless requests_attempted < total_requests_allowed && should_retry?(e)

        sleep(RETRY_DELAY)
        retry
      end
    end

    # Make the API request
    def make_request
      @connection.send(@method) do |request|
        request.url @path
        request.body = @request_body
        request.params = request_query
        request.headers.merge!(@headers)
      end
    end

    # Fetch the body to send with the request
    def request_body
      if @method == :get
        nil
      elsif %i[post put delete].include?(@method)
        @given_options.fetch(:params, {})
      else
        raise "Unknown request method #{@method}"
      end
    end

    # Get the query params to send with the request
    def request_query
      if @method == :get
        @given_options.fetch(:params, {})
      else
        {}
      end
    end

    private

    def should_retry?(exception)
      RETRYABLE_EXCEPTIONS.include?(exception.class)
    end
  end
end
