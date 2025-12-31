module GoCardlessPro
  module Middlewares
    class RaiseGoCardlessErrors < Faraday::Middleware
      API_ERROR_STATUSES = 501..599
      CLIENT_ERROR_STATUSES = 400..500
      API_STATUS_NO_CONTENT = 204

      def on_complete(env)
        if !(env.status == API_STATUS_NO_CONTENT || json?(env)) || API_ERROR_STATUSES.include?(env.status)
          raise ApiError, generate_error_data(env)
        end

        return unless CLIENT_ERROR_STATUSES.include?(env.status)

        json_body ||= JSON.parse(env.body) unless env.body.empty?
        error_type = json_body['error']['type']

        error_class = error_class_for_status(env.status) || error_class_for_type(error_type)

        raise(error_class, json_body['error'])
      end

      private

      def error_class_for_status(code)
        {
          401 => GoCardlessPro::AuthenticationError,
          403 => GoCardlessPro::PermissionError,
          429 => GoCardlessPro::RateLimitError
        }.fetch(code, nil)
      end

      def error_class_for_type(type)
        {
          validation_failed: GoCardlessPro::ValidationError,
          gocardless: GoCardlessPro::GoCardlessError,
          invalid_api_usage: GoCardlessPro::InvalidApiUsageError,
          invalid_state: GoCardlessPro::InvalidStateError
        }.fetch(type.to_sym)
      end

      def generate_error_data(env)
        {
          'message' => "Something went wrong with this request\n" \
                       "code: #{env.status}\n" \
                       "headers: #{env.response_headers}\n" \
                       "body: #{env.body}",
          'code' => env.status
        }
      end

      def json?(env)
        content_type = env.response_headers['Content-Type'] ||
                       env.response_headers['content-type'] || ''

        content_type.include?('application/json')
      end
    end
  end
end

Faraday::Response.register_middleware raise_gocardless_errors: GoCardlessPro::Middlewares::RaiseGoCardlessErrors
