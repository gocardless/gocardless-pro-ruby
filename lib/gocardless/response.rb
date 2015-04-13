module GoCardless
  class Response
    def initialize(response)
      @response = response
    end

    def body
      json? ? handle_json : handle_raw
    end

    def json?
      content_type = @response.headers['Content-Type'] ||
                     @response.headers['content-type'] || ''
      content_type.include?('application/json')
    end

    def error?
      @response.status >= 400
    end

    def meta
      fail ResponseError, 'Cannot fetch meta for non JSON response' unless json?

      json_body.fetch('meta', {})
    end

    def limit
      meta.fetch('limit', nil)
    end

    private

    def json_body
      @json_body ||= JSON.parse(@response.body).with_indifferent_access
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
        validation_failed: GoCardless::ValidationError,
        gocardless: GoCardless::GoCardlessError,
        invalid_api_usage: GoCardless::InvalidApiUsageError,
        invalid_state: GoCardless::InvalidStateError
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
