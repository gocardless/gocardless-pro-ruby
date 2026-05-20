require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'BankAccountDetails Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/bank_account_details/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'bank_account_details' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.bank_account_details.get('BA123',
                                       headers: { 'Gc-Key-Id' => 'PK123' })
    end
  end
end
