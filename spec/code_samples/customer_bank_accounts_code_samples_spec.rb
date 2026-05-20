require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'CustomerBankAccounts Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/customer_bank_accounts'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'customer_bank_accounts' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.customer_bank_accounts.create(
        params: {
          account_holder_name: 'Fran Cosborne',
          account_number: '55779911',
          branch_code: '200000',
          country_code: 'GB',
          links: {
            customer: 'CU123',
          },
        }
      )
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/customer_bank_accounts'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'customer_bank_accounts' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.customer_bank_accounts.list

      @client.customer_bank_accounts.list(
        params: {
          customer: 'CU123',
          enabled: true,
        }
      )
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/customer_bank_accounts/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'customer_bank_accounts' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.customer_bank_accounts.get('BA123')
    end
  end

  describe '#update code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/customer_bank_accounts/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:put, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'customer_bank_accounts' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.customer_bank_accounts.update(
        'BA123',
        params: {
          metadata: { description: 'Business account' },
        }
      )
    end
  end

  describe '#disable code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/customer_bank_accounts/:identity/actions/disable'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'customer_bank_accounts' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.customer_bank_accounts.disable('BA123')
    end
  end
end
