require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'CustomerNotifications Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#handle code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/customer_notifications/:identity/actions/handle'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'customer_notifications' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.customer_notifications.handle('EV1D18JEXAMPLE')
    end
  end
end
