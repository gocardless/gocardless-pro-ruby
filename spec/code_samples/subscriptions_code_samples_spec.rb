require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'Subscriptions Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/subscriptions'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'subscriptions' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.subscriptions.create(
        params: {
          amount: 2500,
          currency: 'GBP',
          name: 'Monthly magazine',
          interval_unit: 'monthly',
          day_of_month: 1,
          links: {
            mandate: 'MD123',
          },
        }
      )
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/subscriptions'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'subscriptions' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.subscriptions.list

      @client.subscriptions.list(params: { customer: 'CU123' })

      @client.subscriptions.list.records.each { |subscription| puts subscription.inspect }
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/subscriptions/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'subscriptions' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.subscriptions.get('SB123')
    end
  end

  describe '#update code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/subscriptions/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:put, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'subscriptions' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.subscriptions.update(
        'SB123',
        params: {
          metadata: { order_no: 'ABCD4321' },
        }
      )
    end
  end

  describe '#pause code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/subscriptions/:identity/actions/pause'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'subscriptions' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.subscriptions.pause('SB123')
    end
  end

  describe '#resume code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/subscriptions/:identity/actions/resume'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'subscriptions' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.subscriptions.resume('SB123')
    end
  end

  describe '#cancel code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/subscriptions/:identity/actions/cancel'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'subscriptions' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.subscriptions.cancel('SB123')
    end
  end
end
