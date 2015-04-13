require_relative './base_service'

# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank

module GoCardless
  module Services
    class HelperService < BaseService
      # Returns a PDF mandate form with a signature field, ready to be signed by your
      # customer. May be fully or partially pre-filled.
      #
      # You must specify `Accept:
      # application/pdf` on requests to this endpoint.
      #
      # Bank account details may
      # either be supplied using the IBAN (international bank account number), or
      # [local
      # details](https://developer.gocardless.com/pro/#ui-compliance-local-bank-details).
      # For more information on the different fields required in each country, please
      # see the [local bank
      # details](https://developer.gocardless.com/pro/#ui-compliance-local-bank-details)
      # section.
      #
      # To generate a mandate in a foreign language, set your
      # `Accept-Language` header to the relevant [ISO
      # 639-1](http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes#Partial_ISO_639_table)
      # language code. Currently Dutch, English, French, German, Italian, Portuguese
      # and Spanish are supported.
      #
      # _Note:_ If you want to render a PDF of an
      # existing mandate you can also do so using the [mandate show
      # endpoint](https://developer.gocardless.com/pro/#mandates-get-a-single-mandate).
      # Example URL: /helpers/mandate
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def mandate(options = {}, custom_headers = {})
        path = '/helpers/mandate'
        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)

        Resources::Helper.new(unenvelope_body(response.body))
      end

      # Check whether an account number and bank / branch code combination are
      # compatible.
      #
      # Bank account details may either be supplied using the IBAN
      # (international bank account number), or [local
      # details](https://developer.gocardless.com/pro/#ui-compliance-local-bank-details).
      # For more information on the different fields required in each country, please
      # see the [local bank
      # details](https://developer.gocardless.com/pro/#ui-compliance-local-bank-details)
      # section.
      # Example URL: /helpers/modulus_check
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def modulus_check(options = {}, custom_headers = {})
        path = '/helpers/modulus_check'
        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)

        Resources::Helper.new(unenvelope_body(response.body))
      end

      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      private

      def envelope_key
        'helpers'
      end

      def sub_url(url, param_map)
        param_map.reduce(url) do |new_url, (param, value)|
          new_url.gsub(":#{param}", value)
        end
      end
    end
  end
end
