require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'BillingRequestFlows Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_request_flows'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_request_flows' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_request_flows.create(
        params: {
          redirect_uri: 'https://my-company.com/landing',
          exit_uri: 'https://my-company.com/exit',
          prefilled_customer: {
            given_name: 'Frank',
            family_name: 'Osborne',
            email: 'frank.osborne@acmeplc.com',
          },
          links: {
            billing_request: 'BRQ123',
          },
        }
      )
    end
  end

  describe '#initialise code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_request_flows/:identity/actions/initialise'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_request_flows' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_request_flows.initialise('BRF123')
    end
  end
end
