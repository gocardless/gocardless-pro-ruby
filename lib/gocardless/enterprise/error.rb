module GoCardless
  class Error < StandardError
    attr_reader :error

    def initialize(error)
      @error = error
    end

    def documentation_url
      @error['documentation_url']
    end

    def message
      @error['message']
    end

    def type
      @error['type']
    end

    def code
      @error['code']
    end

    def request_id
      @error['request_id']
    end

    def errors
      @error['errors']
    end
  end
end
