require 'spec_helper'

describe GoCardlessPro::Resources::ScenarioSimulator do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.scenario_simulators.list }

      before do
        stub_request(:get, %r{.*api.gocardless.com/scenario_simulators}).to_return(
          body: {
            'scenario_simulators' => [{

              'description' => 'description-input',
              'id' => 'id-input',
              'name' => 'name-input',
              'resource_type' => 'resource_type-input',
            }],
            meta: {
              cursors: {
                before: nil,
                after: 'ABC123',
              },
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map(&:class).uniq.first).to eq(GoCardlessPro::Resources::ScenarioSimulator)

        expect(get_list_response.records.first.description).to eq('description-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.name).to eq('name-input')

        expect(get_list_response.records.first.resource_type).to eq('resource_type-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }
    end
  end

  describe '#all' do
    let!(:first_response_stub) do
      stub_request(:get, %r{.*api.gocardless.com/scenario_simulators$}).to_return(
        body: {
          'scenario_simulators' => [{

            'description' => 'description-input',
            'id' => 'id-input',
            'name' => 'name-input',
            'resource_type' => 'resource_type-input',
          }],
          meta: {
            cursors: { after: 'AB345' },
            limit: 1,
          },
        }.to_json,
        headers: response_headers
      )
    end

    let!(:second_response_stub) do
      stub_request(:get, %r{.*api.gocardless.com/scenario_simulators\?after=AB345}).to_return(
        body: {
          'scenario_simulators' => [{

            'description' => 'description-input',
            'id' => 'id-input',
            'name' => 'name-input',
            'resource_type' => 'resource_type-input',
          }],
          meta: {
            limit: 2,
            cursors: {},
          },
        }.to_json,
        headers: response_headers
      )
    end

    it 'automatically makes the extra requests' do
      expect(client.scenario_simulators.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end

  describe '#run' do
    subject(:post_response) { client.scenario_simulators.run(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /scenario_simulators/%v/actions/run
      stub_url = '/scenario_simulators/:identity/actions/run'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'scenario_simulators' => {

            'description' => 'description-input',
            'id' => 'id-input',
            'name' => 'name-input',
            'resource_type' => 'resource_type-input',
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

                'description' => 'description-input',
                'id' => 'id-input',
                'name' => 'name-input',
                'resource_type' => 'resource_type-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
