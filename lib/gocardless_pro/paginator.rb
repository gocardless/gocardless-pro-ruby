module GoCardlessPro
  # A class that can take an API LIST query and auto paginate through results
  class Paginator
    # initialize a paginator
    # @param options [Hash]
    # @option options :service the service class to use to make requests to
    # @option options :options additional options to send with the requests
    def initialize(options = {})
      @service = options.fetch(:service)
      @options = options.fetch(:options)
      @uri_params = options.reject { |k, _| %i[service options].include?(k) }
    end

    # Get a lazy enumerable for listing data from the API
    def enumerator
      response = get_initial_response
      Enumerator.new do |yielder|
        loop do
          response.records.each { |item| yielder << item }

          after_cursor = response.after
          break if after_cursor.nil?

          @options[:params] ||= {}
          @options[:params] = @options[:params].merge(after: after_cursor)
          response = @service.list(*@uri_params.values, @options.merge(after: after_cursor))
        end
      end.lazy
    end

    private

    def get_initial_response
      @initial_response ||= @service.list(*@uri_params.values, @options)
    end
  end
end
