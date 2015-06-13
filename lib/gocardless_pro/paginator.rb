module GoCardlessPro
  # A class that can take an API LIST query and auto paginate through results
  class Paginator
    # initialize a paginator
    # @param options [Hash]
    # @option options :service the service class to use to make requests to
    # @option options :path the path to make the request to
    # @option options :options additional options to send with the requests
    def initialize(options = {})
      @service = options.fetch(:service)
      @resource_class = options.fetch(:resource_class)
      @path = options.fetch(:path)
      @options = options.fetch(:options)
    end

    # Get a lazy enumerable for listing data from the API
    def enumerator
      response = get_initial_response
      Enumerator.new do |yielder|
        loop do
          items = @service.unenvelope_body(response.body).map do |item|
            @resource_class.new(item)
          end

          items.each { |item| yielder << item }

          after_cursor = response.meta['cursors']['after']
          break if after_cursor.nil?

          @options[:params] ||= {}
          @options[:params] = @options[:params].merge(after: after_cursor)
          response = @service.make_request(:get, @path, @options.merge(after: after_cursor))
        end
      end.lazy
    end

    private

    def get_initial_response
      @initial_response ||= @service.make_request(:get, @path, @options)
    end
  end
end
