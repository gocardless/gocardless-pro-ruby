require 'spec_helper'

describe GoCardlessPro::Services::ScenarioSimulatorsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.scenario_simulators.list }

      let(:body) do
        {
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
        }.to_json
      end

      before do
        stub_request(:get, %r{.*api.gocardless.com/scenario_simulators}).to_return(
          body: body,
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

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:get, %r{.*api.gocardless.com/scenario_simulators}).
                 to_timeout.then.to_return(status: 200, headers: response_headers, body: body)

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/scenario_simulators}).
                 to_return(status: 502,
                           headers: { 'Content-Type' => 'text/html' },
                           body: '<html><body>Response from Cloudflare</body></html>').
                 then.to_return(status: 200, headers: response_headers, body: body)

          get_list_response
          expect(stub).to have_been_requested.twice
        end
      end
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

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/scenario_simulators$}).to_return(
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

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/scenario_simulators\?after=AB345}).
                               to_timeout.then.
                               to_return(
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

        client.scenario_simulators.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/scenario_simulators$}).to_return(
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

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/scenario_simulators\?after=AB345}).
                               to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
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

        client.scenario_simulators.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
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

    describe 'retry behaviour' do
      it "doesn't retry errors" do
        stub_url = '/scenario_simulators/:identity/actions/run'.gsub(':identity', resource_id)
        stub = stub_request(:post, /.*api.gocardless.com#{stub_url}/).
               to_timeout

        expect { post_response }.to raise_error(Faraday::ConnectionFailed)
        expect(stub).to have_been_requested
      end
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
