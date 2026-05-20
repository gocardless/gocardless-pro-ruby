require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'OutboundPayments Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payments'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payments.create(
        params: {
          amount: 1000,
          scheme: 'faster_payments',
          description: 'Reward Payment (August 2024)',
          reference: 'Invoice 123',
          links: {
            creditor: 'CR123',
            recipient_bank_account: 'BA123',
          },
        }
      )
    end
  end

  describe '#withdraw code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payments/withdrawal'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payments.withdraw(
        params: {
          amount: 5000,
          scheme: 'faster_payments',
          description: 'Withdraw funds to business account',
          links: {
            creditor: 'CR123',
          },
        }
      )
    end
  end

  describe '#cancel code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payments/:identity/actions/cancel'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payments.cancel('OUT123')
    end
  end

  describe '#approve code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payments/:identity/actions/approve'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payments.approve('OUT123')
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payments/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payments.get('OUT123')
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payments'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payments' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payments.list(params: { limit: 10 })
    end
  end

  describe '#update code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payments/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:put, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payments.update(
        'OUT123',
        params: {
          metadata: {
            invoice_id: 'INV-1234',
          },
        }
      )
    end
  end

  describe '#stats code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/outbound_payments/stats'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'outbound_payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.outbound_payments.stats
    end
  end
end
