require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'MandatePdfs Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/mandate_pdfs'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'mandate_pdfs' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.mandate_pdfs.create(
        params: {
          links: { mandate: 'MD123' },
        }
      )

      @client.mandate_pdfs.create(
        params: {
          account_number: '55779911',
          branch_code: '200000',
          country_code: 'GB',
        }
      )

      @client.mandate_pdfs.create(
        params: {
          iban: 'FR14BARC20000055779911',
        },
        headers: {
          'Accept-Language' => 'fr',
        }
      )
    end
  end
end
