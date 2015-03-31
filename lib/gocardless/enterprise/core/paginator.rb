module GoCardless::Enterprise
  module Core
    class Paginator
      LIMIT_INCREMENT = 50

      def initialize(request, initial_response, options)
        @request = request
        @options = options
        @initial_response = initial_response
      end

      def enumerator
        response = @initial_response
        Enumerator.new do |yielder|
          loop do
            items = @request.unenvelope(response.body)
            items.each { |item| yielder << item }

            break if items.count < response.limit

            new_options = @options.dup
            new_options[:query] = @options.fetch(:query, {})
            new_options[:query].merge!(after: response.meta['cursors']['after'],
                                       limit: response.limit + LIMIT_INCREMENT)

            response = @request.make_request(new_options)
          end
        end.lazy
      end
    end
  end
end
