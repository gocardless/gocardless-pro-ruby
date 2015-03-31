module GoCardless::Enterprise
  module Resources
    class Base
      def make_request(method, path, options)
        @client.make_request(method, path, options.merge(envelope_key: envelope_key))
      end

      def envelope_key
        raise NotImplementedError
      end
    end
  end
end
