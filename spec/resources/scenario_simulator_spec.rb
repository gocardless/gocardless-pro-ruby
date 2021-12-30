require 'spec_helper'

describe GoCardlessPro::Resources::ScenarioSimulator do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#run' do
    subject(:post_response) { client.scenario_simulators.run(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /scenario_simulators/%v/actions/run
      stub_url = '/scenario_simulators/:identity/actions/run'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(

        body: {
          'scenario_simulators' => {

            'id' => 'id-input',
          },
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::ScenarioSimulator)

      expect(stub).to have_been_requested
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:post_response) { client.scenario_simulators.run(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /scenario_simulators/%v/actions/run
        stub_url = '/scenario_simulators/:identity/actions/run'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'scenario_simulators' => {

                'id' => 'id-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
