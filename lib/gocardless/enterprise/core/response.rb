module GoCardless::Enterprise
  module Core
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
        unless json?
          raise ResponseError, 'Cannot fetch meta for non JSON response'
        end

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
        error? ? raise(ApiError, json_body['error']) : json_body
      end

      def handle_raw
        default_raw_message = {
          'message' => "Something went wrong with this raw request\n" \
          "status: #{@response.status}\n" \
          "headers: #{@response.headers}\n" \
          "body: #{@response.body}"
        }
        error? ? raise(ApiError, default_raw_message) : raw_body
      end
    end
  end
end
