require_relative './base_service'
require 'uri'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the Subscription endpoints
    class SubscriptionsService < BaseService
      # Creates a new subscription object
      # Example URL: /subscriptions
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/subscriptions'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params
        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::Subscription.new(unenvelope_body(response.body), response)
      end

      # Returns a [cursor-paginated](#api-usage-cursor-pagination) list of your
      # subscriptions.
      # Example URL: /subscriptions
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/subscriptions'

        response = make_request(:get, path, options)
        ListResponse.new(
          response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Subscription
        )
      end

      # Get a lazily enumerated list of all the items returned. This is simmilar to the `list` method but will paginate for you automatically.
      #
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          options: options
        ).enumerator
      end

      # Retrieves the details of a single subscription.
      # Example URL: /subscriptions/:identity
      #
      # @param identity       # Unique identifier, beginning with "SB".
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/subscriptions/:identity', 'identity' => identity)

        response = make_request(:get, path, options)

        return if response.body.nil?

        Resources::Subscription.new(unenvelope_body(response.body), response)
      end

      # Updates a subscription object.
      # Example URL: /subscriptions/:identity
      #
      # @param identity       # Unique identifier, beginning with "SB".
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/subscriptions/:identity', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params
        response = make_request(:put, path, options)

        return if response.body.nil?

        Resources::Subscription.new(unenvelope_body(response.body), response)
      end

      # Immediately cancels a subscription; no more payments will be created under it.
      # Any metadata supplied to this endpoint will be stored on the payment
      # cancellation event it causes.
      #
      # This will fail with a cancellation_failed
      # error if the subscription is already cancelled or finished.
      # Example URL: /subscriptions/:identity/actions/cancel
      #
      # @param identity       # Unique identifier, beginning with "SB".
      # @param options [Hash] parameters as a hash, under a params key.
      def cancel(identity, options = {})
        path = sub_url('/subscriptions/:identity/actions/cancel', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params
        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::Subscription.new(unenvelope_body(response.body), response)
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
        'subscriptions'
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
