require 'spec_helper'

describe GoCardlessPro::Resources::BankAccountDetail do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.bank_account_details.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/bank_account_details/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/)
          .with(headers: { 'Foo' => 'Bar' })
          .to_return(
            body: {
              'bank_account_details' => {

                'ciphertext' => 'ciphertext-input',
                'encrypted_key' => 'encrypted_key-input',
                'iv' => 'iv-input',
                'protected' => 'protected-input',
                'tag' => 'tag-input'
              }
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.bank_account_details.get(id, headers: {
                                          'Foo' => 'Bar'
                                        })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a bank_account_detail to return' do
      before do
        stub_url = '/bank_account_details/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'bank_account_details' => {

              'ciphertext' => 'ciphertext-input',
              'encrypted_key' => 'encrypted_key-input',
              'iv' => 'iv-input',
              'protected' => 'protected-input',
              'tag' => 'tag-input'
            }
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::BankAccountDetail)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/bank_account_details/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: '',
          headers: response_headers
        )
      end

      it 'returns nil' do
        expect(get_response).to be_nil
      end
    end

    context "when an ID is specified which can't be included in a valid URI" do
      let(:id) { '`' }

      it "doesn't raise an error" do
        expect { get_response }.to_not raise_error(/bad URI/)
      end
    end
  end
end
