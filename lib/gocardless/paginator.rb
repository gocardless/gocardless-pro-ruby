module GoCardless
  class Paginator
    def initialize(options = {})
      @service = options.fetch(:service)
      @path = options.fetch(:path)
      @options = options.fetch(:options)
    end

    def enumerator
      response = get_initial_response
      Enumerator.new do |yielder|
        loop do
          items = @service.unenvelope_body(response.body)
          items.each { |item| yielder << item }

          after_cursor = response.meta['cursors']['after']
          break if after_cursor.nil?

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
