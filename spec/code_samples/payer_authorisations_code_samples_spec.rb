require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'PayerAuthorisations Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payer_authorisations/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payer_authorisations' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payer_authorisations.get('PAU123')
    end
  end

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payer_authorisations'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payer_authorisations' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payer_authorisations.create(
        params: {
          "customer": {
            "email": 'mail@example.com',
            "given_name": 'Name',
            "family_name": 'Surname',
            "metadata": {
              "salesforce_id": 'EFGH5678',
            },
          },
          "bank_account": {
            "account_holder_name": 'Name Surname',
            "branch_code": '200000',
            "account_number": '55779911',
            "metadata": {},
          },
          "mandate": {
            "reference": 'XYZ789',
            "metadata": {},
          },
        }
      )
    end
  end

  describe '#update code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payer_authorisations/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:put, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payer_authorisations' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payer_authorisations.update(
        'PA123',
        params: {
          "customer": {
            "email": 'mail@example.com',
            "given_name": 'Name',
            "family_name": 'Surname',
            "metadata": {
              "salesforce_id": 'EFGH5678',
            },
          },
          "bank_account": {
            "account_holder_name": 'Name Surname',
            "branch_code": '200000',
            "account_number": '55779911',
          },
          "mandate": {
            "reference": 'XYZ789',
          },
        }
      )
    end
  end

  describe '#submit code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payer_authorisations/:identity/actions/submit'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payer_authorisations' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payer_authorisations.submit('PAU123')
    end
  end

  describe '#confirm code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/payer_authorisations/:identity/actions/confirm'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payer_authorisations' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payer_authorisations.confirm('PAU123')
    end
  end
end
