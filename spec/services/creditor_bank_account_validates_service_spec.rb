require 'spec_helper'

describe GoCardlessPro::Services::CreditorBankAccountValidatesService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#validate' do
    subject(:post_response) { client.creditor_bank_account_validates.validate }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /creditor_bank_accounts/validate
      stub_url = '/creditor_bank_accounts/validate'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'creditor_bank_accounts' => {

            'bank_name' => 'bank_name-input',
            'icon_url' => 'icon_url-input',
            'invalid_reasons' => 'invalid_reasons-input',
            'is_valid' => 'is_valid-input'
          }
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::CreditorBankAccountValidate)

      expect(stub).to have_been_requested
    end

    describe 'retry behaviour' do
      it "doesn't retry errors" do
        stub_url = '/creditor_bank_accounts/validate'.gsub(':identity', resource_id)
        stub = stub_request(:post, /.*api.gocardless.com#{stub_url}/)
               .to_timeout

        expect { post_response }.to raise_error(Faraday::ConnectionFailed)
        expect(stub).to have_been_requested
      end
    end

    context 'when the request needs a body and custom header' do
      subject(:post_response) { client.creditor_bank_account_validates.validate(body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /creditor_bank_accounts/validate
        stub_url = '/creditor_bank_accounts/validate'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/)
          .with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'creditor_bank_accounts' => {

                'bank_name' => 'bank_name-input',
                'icon_url' => 'icon_url-input',
                'invalid_reasons' => 'invalid_reasons-input',
                'is_valid' => 'is_valid-input'
              }
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
