module GoCardlessPro
  # A class to wrap an API response
  class Response
    # Initialize a response instance
    # @param response an API response
    def initialize(response)
      @response = response
    end

    # Return the body of the API response
    def body
      json? ? handle_json : handle_raw
    end

    # Returns true if the response is JSON
    def json?
      content_type = @response.headers['Content-Type'] ||
                     @response.headers['content-type'] || ''
      content_type.include?('application/json')
    end

    # Returns true if the response is an error
    def error?
      @response.status >= 400
    end

    # Returns the meta hash of the response
    def meta
      fail ResponseError, 'Cannot fetch meta for non JSON response' unless json?

      json_body.fetch('meta', {})
    end

    # Returns the limit parameter from the response
    def limit
      meta.fetch('limit', nil)
    end

    private

    def json_body
      @json_body ||= JSON.parse(@response.body) unless @response.body.empty?
    end

    def raw_body
      @response.body
    end

    def handle_json
      if error?
        type = json_body['error']['type']
        fail(error_class_for_type(type), json_body['error'])
      else
        json_body
      end
    end

    def error_class_for_type(type)
      {
        validation_failed: GoCardlessPro::ValidationError,
        gocardless: GoCardlessPro::GoCardlessError,
        invalid_api_usage: GoCardlessPro::InvalidApiUsageError,
        invalid_state: GoCardlessPro::InvalidStateError
      }.fetch(type.to_sym)
    end

    def handle_raw
      default_raw_message = {
        'message' => "Something went wrong with this raw request\n" \
        "status: #{@response.status}\n" \
        "headers: #{@response.headers}\n" \
        "body: #{@response.body}"
      }
      error? ? fail(ApiError, default_raw_message) : raw_body
    end
  end
end
