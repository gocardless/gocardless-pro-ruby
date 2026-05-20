require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'OutboundPaymentImports Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payment_imports'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payment_imports' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payment_imports.create(
        params: {
          entry_items: [
            {
              amount: 1000,
              scheme: 'faster_payments',
              reference: 'Invoice 123',
              recipient_bank_account_id: 'BA123',
            },
            {
              amount: 2000,
              scheme: 'faster_payments',
              reference: 'Invoice 124',
              recipient_bank_account_id: 'BA456',
              metadata: {
                order_id: 'ORD-789',
              },
            },
          ],
          links: {
            creditor: 'CR123',
          },
        }
      )
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payment_imports/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payment_imports' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payment_imports.get('IM123')
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payment_imports'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payment_imports' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payment_imports.list(params: { limit: 10 })
    end
  end
end
