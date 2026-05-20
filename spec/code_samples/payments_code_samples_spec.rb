require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'Payments Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payments'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payments.create(
        params: {
          amount: 1000,
          currency: 'GBP',
          description: 'Club membership fee',
          links: {
            mandate: 'MD123',
          },
        },
        headers: {
          'Idempotency-Key' => 'aaf50eb0-8ddb-4900-a97b-40ed794570a1',
        }
      )
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payments'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payments' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payments.list

      @client.payments.list(params: { customer: 'CU123' })

      @client.payments.list.records.each { |payment| puts payment.inspect }
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payments/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payments.get('PM123')
    end
  end

  describe '#update code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payments/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:put, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payments.update(
        'PM123',
        params: {
          metadata: { order_id: 'transaction-0HE9WQ0WDE' },
        }
      )
    end
  end

  describe '#cancel code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payments/:identity/actions/cancel'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payments.cancel('PM123')
    end
  end

  describe '#retry code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payments/:identity/actions/retry'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payments' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payments.retry('PM123')
    end
  end
end
