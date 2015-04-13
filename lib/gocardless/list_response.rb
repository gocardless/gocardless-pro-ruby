module GoCardless
  class ListResponse
    include Enumerable

    def initialize(options = {})
      @raw_response = options.fetch(:raw_response)
      @resource_class = options.fetch(:resource_class)
      @unenveloped_body = options.fetch(:unenveloped_body)

      @items = @unenveloped_body.map { |item| @resource_class.new(item) }
    end

    def each(&block)
      @items.each(&block)
    end

    def before
      @raw_response.body[:meta][:cursors][:before]
    end

    def after
      @raw_response.body[:meta][:cursors][:after]
    end
  end
end
