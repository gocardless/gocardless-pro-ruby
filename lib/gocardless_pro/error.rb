module GoCardlessPro
  # A class to represent an API Error
  class Error < StandardError
    attr_reader :error

    # intialize a new error
    #  @param error the error from the API
    def initialize(error)
      raise ArgumentError, 'GoCardless errors expect a hash' unless error.is_a?(Hash)

      @error = error
    end

    # access the documentation_url from the response
    def documentation_url
      @error['documentation_url']
    end

    # access the message from the response
    def message
      @error['message']
    end

    def to_s
      if errors.any?
        errors.
          map { |err| "#{err['field']} #{err['message']}" }.
          join(', ')
      else
        @error['message']
      end
    end

    # access the type from the response
    def type
      @error['type']
    end

    # access the code from the response
    def code
      @error['code']
    end

    # access the request_id from the response
    def request_id
      @error['request_id']
    end

    # access the errors from the response
    def errors
      @error.fetch('errors', [])
    end
  end
end
