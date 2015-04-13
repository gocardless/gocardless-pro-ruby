module GoCardless
  class Request
    def initialize(connection, method, path, options, headers)
      @connection = connection
      @method = method
      @path = path
      @headers = headers || {}
      @envelope_name = options.delete(:envelope_key)
      @given_options = options

      @request_body = request_body

      if @request_body.is_a?(Hash)
        @request_body = @request_body.to_json
        @headers['Content-Type'] ||= 'application/json'
      end
    end

    def request
      Response.new(make_request)
    end

    def make_request(opts = {})

      @connection.send(@method) do |request|
        request.url @path
        request.body = @request_body
        request.params = request_query
        request.headers.merge!(@headers)
      end
    end

    def request_body
      if @method == :get
        nil
      elsif @method == :post || @method == :put
        @given_options
      else
        raise "unknown method #{@method}"
      end
    end

    def request_query
      if @method == :get
        @given_options
      elsif @method == :post || @method == :put
        {}
      else
        raise "unknown method #{@method}"
      end
    end

    # TODO (JF): once paginator is rewritten this wont be needed, I think
    def unenvelope(body)
      body[@envelope_name] || body['data']
    end

    private

    def options
      { headers: @headers, body: @body, query: @query }
    end
  end
end
