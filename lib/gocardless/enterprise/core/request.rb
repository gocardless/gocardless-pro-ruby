module GoCardless::Enterprise
  module Core
    class Request
      def initialize(connection, method, path, options)
        @connection = connection
        @method = method
        @path = path
        @headers = options[:headers] || {}
        @body = options[:body] || nil
        @query = options[:query] || {}
        @envelope_name = options[:envelope_key] || 'data'
      end

      def request
        response = Response.new(make_request)
        return response.body unless response.json?

        if response.limit.nil?
          unenvelope(response.body)
        else
          Paginator.new(self, response, options).enumerator
        end
      end

      def make_request(opts = options)
        body = opts[:body]
        headers = opts.fetch(:headers, {})
        query = opts[:query]

        # TODO: Not sure this is required in faraday 0.9.0
        if body.is_a?(Hash)
          body = body.to_json
          headers['Content-Type'] ||= 'application/json'
        end

        @connection.send(@method) do |request|
          request.url @path
          request.body = body
          request.params = query
          request.headers.merge!(headers)
        end
      end

      def unenvelope(body)
        body[@envelope_name] || body['data']
      end

      private

      def options
        { headers: @headers, body: @body, query: @query }
      end
    end
  end
end
