require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'MandateImportEntries Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/mandate_import_entries'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'mandate_import_entries' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.mandate_import_entries.create(params: {
                                              links: {
                                                mandate_import: 'IM000010790WX1',
                                              },
                                              record_identifier: 'bank-file.xml/line-1',
                                              customer: {
                                                company_name: "Jane's widgets",
                                                email: 'jane@janeswidgets.fr',
                                              },
                                              bank_account: {
                                                account_holder_name: 'Jane Doe',
                                                iban: 'FR14BARC20000055779911',
                                              },
                                              amendment: {
                                                original_mandate_reference: 'REFNMANDATE',
                                                original_creditor_id: 'FR123OTHERBANK',
                                                original_creditor_name: 'Existing DD Provider',
                                              },
                                            })
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/mandate_import_entries'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'mandate_import_entries' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.mandate_import_entries.all(
        params: {
          'mandate_import' => 'IM000010790WX1',
        }
      ).each { |entry| puts entry.record_identifier }
    end
  end
end
