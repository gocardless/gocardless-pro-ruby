require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'RedirectFlows Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/redirect_flows'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'redirect_flows' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.redirect_flows.create(
        params: {
          description: 'Team membership',
          session_token: 'my_unique_tracking_id',
          success_redirect_url: 'https://example.com/pay/confirm',
          prefilled_customer: {
            given_name: 'Frank',
            family_name: 'Osborne',
            email: 'frank.osborne@acmeplc.com',
          },
        }
      )
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/redirect_flows/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'redirect_flows' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.redirect_flows.get('RE123')
    end
  end

  describe '#complete code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/redirect_flows/:identity/actions/complete'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'redirect_flows' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.redirect_flows.complete(
        'RE123',
        params: {
          session_token: 'my_unique_tracking_id',
        }
      )
    end
  end
end
