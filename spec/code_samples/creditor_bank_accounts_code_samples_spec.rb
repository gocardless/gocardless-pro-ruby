require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'CreditorBankAccounts Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/creditor_bank_accounts'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'creditor_bank_accounts' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.creditor_bank_accounts.create(
        params: {
          account_holder_name: 'Example Ltd',
          account_number: '55779911',
          branch_code: '200000',
          country_code: 'GB',
          links: {
            creditor: 'CR123',
          },
        }
      )
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/creditor_bank_accounts'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'creditor_bank_accounts' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.creditor_bank_accounts.list

      @client.creditor_bank_accounts.list(params: { enabled: true })
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/creditor_bank_accounts/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'creditor_bank_accounts' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.creditor_bank_accounts.get('BA123')
    end
  end

  describe '#disable code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/creditor_bank_accounts/:identity/actions/disable'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'creditor_bank_accounts' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.creditor_bank_accounts.disable('BA123')
    end
  end
end
