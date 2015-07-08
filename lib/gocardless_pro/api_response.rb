module GoCardlessPro
  # wraps a faraday response object with some accessors
  class ApiResponse
    extend Forwardable

    def initialize(response)
      @response = response
    end

    def_delegator :@response, :headers
    def_delegator :@response, :body
    def_delegator :@response, :status_code
  end
end
