require 'spec_helper'

describe GoCardlessPro::Services::FundsAvailabilitiesService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#check' do
    subject(:get_response) { client.funds_availabilities.check(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /funds_availability/%v
      stub_url = '/funds_availability/:identity'.gsub(':identity', resource_id)
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'funds_availability' => {

            'available' => 'available-input',
          },
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(get_response).to be_a(GoCardlessPro::Resources::FundsAvailability)

      expect(stub).to have_been_requested
    end

    describe 'retry behaviour' do
      it "doesn't retry errors" do
        stub_url = '/funds_availability/:identity'.gsub(':identity', resource_id)
        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_timeout

        expect { get_response }.to raise_error(Faraday::ConnectionFailed)
        expect(stub).to have_been_requested
      end
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:get_response) { client.funds_availabilities.check(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /funds_availability/%v
        stub_url = '/funds_availability/:identity'.gsub(':identity', resource_id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'funds_availability' => {

                'available' => 'available-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
