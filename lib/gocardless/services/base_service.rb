module GoCardless
  module Services
    class BaseService
      def initialize(api_service)
        @api_service = api_service
      end

      def make_request(method, path, options = {}, custom_headers = {})
        @api_service.make_request(method, path, options.merge(envelope_key: envelope_key), custom_headers)
      end

      def envelope_key
        fail NotImplementedError
      end
    end
  end
end
