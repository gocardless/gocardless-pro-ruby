require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'PayerThemes Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create_for_creditor code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/branding/payer_themes'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'payer_themes' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.payer_themes.create_for_creditor(
        params: {
          "header_background_colour": '#BD10E0',
          "link_text_colour": '#7ED321',
          "button_background_colour": '#128DAA',
          "content_box_border_colour": '#BD10E0',
          "links": {
            "creditor": 'CR123',
          },
        }
      )
    end
  end
end
