require_relative './base_service'
require 'uri'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the CustomerNotification endpoints
    class CustomerNotificationsService < BaseService
      # "Handling" a notification means that you have sent the notification yourself
      # (and
      # don't want GoCardless to send it).
      # If the notification has already been actioned, or the deadline to notify has
      # passed,
      # this endpoint will return an `already_actioned` error and you should not take
      # further action.
      #
      # Example URL: /customer_notifications/:identity/actions/handle
      #
      # @param identity       # The id of the notification.
      # @param options [Hash] parameters as a hash, under a params key.
      def handle(identity, options = {})
        path = sub_url('/customer_notifications/:identity/actions/handle', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params

        options[:retry_failures] = false

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::CustomerNotification.new(unenvelope_body(response.body), response)
      end

      private

      # Unenvelope the response of the body using the service's `envelope_key`
      #
      # @param body [Hash]
      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      # return the key which API responses will envelope data under
      def envelope_key
        'customer_notifications'
      end

      # take a URL with placeholder params and substitute them out for the actual value
      # @param url [String] the URL with placeholders in
      # @param param_map [Hash] a hash of placeholders and their actual values (which will be escaped)
      def sub_url(url, param_map)
        param_map.reduce(url) do |new_url, (param, value)|
          new_url.gsub(":#{param}", URI.escape(value))
        end
      end
    end
  end
end
