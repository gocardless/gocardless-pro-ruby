require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'SchemeIdentifiers Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/scheme_identifiers'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'scheme_identifiers' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.scheme_identifiers.create(
        params: {
          scheme: 'bacs',
          name: 'Example Ltd',
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
      stub_url = '/scheme_identifiers'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'scheme_identifiers' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.scheme_identifiers.list.records
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/scheme_identifiers/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'scheme_identifiers' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.scheme_identifiers.get('SU123')
    end
  end
end
