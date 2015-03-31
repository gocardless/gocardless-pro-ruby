module GoCardless::Enterprise
  module Core
    class SchemaError < StandardError; end

    class ResponseError < StandardError; end

    class ApiError < StandardError
      attr_reader :error

      def initialize(error)
        @error = error
        if @error.key?('documentation_url')
          super("#{@error['message']}, see #{@error['documentation_url']}")
        else
          super("#{@error['message']}")
        end
      end
    end
  end
end
