module GoCardlessPro
  # wraps a faraday response object with some accessors
  class ApiResponse
    extend Forwardable

    def initialize(response)
      @response = response
    end

    def_delegator :@response, :headers, :headers
    def_delegator :@response, :status, :status
    def_delegator :@response, :body, :body
  end
end
