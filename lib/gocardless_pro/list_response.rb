module GoCardlessPro
  # Wraps a response from an API LIST endpoint
  class ListResponse
    attr_reader :records

    # Initialize a list response
    # @param options [Hash]
    # @option option :raw_response the raw API response
    # @option option :resource_class the class for the resource returned by the API
    # @option option :unenveloped_body the parsed response from the API
    def initialize(options = {})
      @raw_response = options.fetch(:raw_response)
      @resource_class = options.fetch(:resource_class)
      @unenveloped_body = options.fetch(:unenveloped_body)

      @records = @unenveloped_body.map { |item| @resource_class.new(item) }
    end

    # return the before cursor for paginating
    def before
      @raw_response.body['meta']['cursors']['before']
    end

    # return the after cursor for paginating
    def after
      @raw_response.body['meta']['cursors']['after']
    end
  end
end
