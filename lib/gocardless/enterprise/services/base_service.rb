module GoCardless
  module Services
    class BaseService
      def initialize(api_service)
        @api_service = api_service
      end

      def make_request(method, path, options)
        @api_service.make_request(method, path, options.merge(envelope_key: envelope_key))
      end

      def envelope_key
        raise NotImplementedError
      end
    end
  end
end

