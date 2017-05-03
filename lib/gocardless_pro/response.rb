module GoCardlessPro
  # A class to wrap an API response
  class Response
    extend Forwardable

    def_delegator :@response, :headers
    def_delegator :@response, :status, :status_code

    # Initialize a response instance
    # @param response an API response
    def initialize(response)
      @response = response
    end

    # Return the body of parsed JSON body of the API response
    def body
      JSON.parse(@response.body) unless @response.body.empty?
    end

    # Returns the meta hash of the response
    def meta
      json_body.fetch('meta', {})
    end

    # Returns the limit parameter from the response
    def limit
      meta.fetch('limit', nil)
    end
  end
end
