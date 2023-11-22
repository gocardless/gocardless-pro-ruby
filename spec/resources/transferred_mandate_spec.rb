require 'spec_helper'

describe GoCardlessPro::Resources::TransferredMandate do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#transferred_mandates' do
    subject(:get_response) { client.transferred_mandates.transferred_mandates(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /transferred_mandate/%v
      stub_url = '/transferred_mandate/:identity'.gsub(':identity', resource_id)
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'transferred_mandate' => {

            'encrypted_data' => 'encrypted_data-input',
            'key' => 'key-input',
            'kid' => 'kid-input',
            'links' => 'links-input',
          },
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(get_response).to be_a(GoCardlessPro::Resources::TransferredMandate)

      expect(stub).to have_been_requested
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:get_response) { client.transferred_mandates.transferred_mandates(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /transferred_mandate/%v
        stub_url = '/transferred_mandate/:identity'.gsub(':identity', resource_id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'transferred_mandate' => {

                'encrypted_data' => 'encrypted_data-input',
                'key' => 'key-input',
                'kid' => 'kid-input',
                'links' => 'links-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
