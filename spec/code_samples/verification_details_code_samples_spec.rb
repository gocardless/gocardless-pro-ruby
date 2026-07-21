require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'VerificationDetails Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/verification_details'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'verification_details' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.verification_details.create(params: {
                                            name: 'Acme',
                                            company_number: '03768189',
                                            address_line1: '12 Drury lane',
                                            city: 'London',
                                            description: 'wine and cheese seller',
                                            postal_code: 'B4 7NJ',
                                            directors: [{
                                              given_name: 'Gandalf',
                                              family_name: 'Grey',
                                              city: 'London',
                                              date_of_birth: '1986-02-19',
                                              street: 'Drury lane',
                                              postal_code: 'B4 7NJ',
                                              country_code: 'GB',
                                            }],
                                            links: {
                                              creditor: 'CR123',
                                            },
                                          })
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/verification_details'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'verification_details' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.verification_details.list(params: {
                                          creditor: 'CR123',
                                        }).records
    end
  end
end
