require 'openssl'

module GoCardlessPro
  class Webhook
    class InvalidSignatureError < StandardError; end

    class << self
      # Validates that a webhook was genuinely sent by GoCardless using
      # `.signature_valid?`, and then parses it into an array of
      # `GoCardlessPro::Resources::Event` objects representing each event
      # included in the webhook
      #
      # @option options [String] :request_body the request body
      # @option options [String] :signature_header the signature included in the request,
      #   found in the `Webhook-Signature` header
      # @option options [String] :webhook_endpoint_secret the webhook endpoint secret for
      #   your webhook endpoint, as configured in your GoCardless Dashboard
      # @return [Array<GoCardlessPro::Resources::Event>] the events included
      #   in the webhook
      # @raise [InvalidSignatureError] if the signature header specified does not match
      #   the signature computed using the request body and webhook endpoint secret
      # @raise [ArgumentError] if a required keyword argument is not provided or is not
      #   of the required type
      def parse(options = {})
        validate_options!(options)

        unless signature_valid?(request_body: options[:request_body],
                                signature_header: options[:signature_header],
                                webhook_endpoint_secret: options[:webhook_endpoint_secret])
          raise InvalidSignatureError, "This webhook doesn't appear to be a genuine " \
                                        'webhook from GoCardless, because the signature ' \
                                        "header doesn't match the signature computed" \
                                        ' with your webhook endpoint secret.'
        end

        events = JSON.parse(options[:request_body])['events']

        events.map { |event| Resources::Event.new(event) }
      end

      # Validates that a webhook was genuinely sent by GoCardless by computing its
      # signature using the body and your webhook endpoint secret, and comparing that with
      # the signature included in the `Webhook-Signature` header
      #
      # @option options [String] :request_body the request body
      # @option options [String] :signature_header the signature included in the request,
      #   found in the `Webhook-Signature` header
      # @option options [String] :webhook_endpoint_secret the webhook endpoint secret for
      #   your webhook endpoint, as configured in your GoCardless Dashboard
      # @return [Boolean] whether the webhook's signature is valid
      # @raise [ArgumentError] if a required keyword argument is not provided or is not
      #   of the required type
      def signature_valid?(options = {})
        validate_options!(options)

        computed_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'),
                                                     options[:webhook_endpoint_secret],
                                                     options[:request_body])

        secure_compare(options[:signature_header], computed_signature)
      end

      private

      # Performs a "constant time" comparison of two strings, safe against timing attacks
      #
      # Vendored from Rack's `Rack::Utils.secure_compare`
      # (https://github.com/rack/rack/blob/eb040cf1bbb1b2dacd496ab0aa549de8408d8a27/lib/rack/utils.rb#L368-L382).
      # Licensed under The MIT License (MIT). Copyright (C) 2007-2018 Christian
      # Neukirchen.
      def secure_compare(a, b)
        return false unless a.bytesize == b.bytesize

        l = a.unpack('C*')

        r = 0
        i = -1
        b.each_byte { |v| r |= v ^ l[i += 1] }
        r == 0
      end

      def validate_options!(options)
        unless options[:request_body].is_a?(String)
          raise ArgumentError, 'request_body must be provided and must be a string'
        end

        unless options[:signature_header].is_a?(String)
          raise ArgumentError, 'signature_header must be provided and must be a string'
        end

        return if options[:webhook_endpoint_secret].is_a?(String)

        raise ArgumentError, 'webhook_endpoint_secret must be provided and must be a ' \
                             'string'
      end
    end
  end
end
