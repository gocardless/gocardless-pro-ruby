require 'spec_helper'

describe GoCardlessPro::Services::BillingRequestFlowsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.billing_request_flows.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'authorisation_url' => 'authorisation_url-input',
          'auto_fulfil' => 'auto_fulfil-input',
          'created_at' => 'created_at-input',
          'exit_uri' => 'exit_uri-input',
          'expires_at' => 'expires_at-input',
          'id' => 'id-input',
          'links' => 'links-input',
          'lock_bank_account' => 'lock_bank_account-input',
          'lock_customer_details' => 'lock_customer_details-input',
          'redirect_uri' => 'redirect_uri-input',
          'session_token' => 'session_token-input',
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/billing_request_flows}).
          with(
            body: {
              'billing_request_flows' => {

                'authorisation_url' => 'authorisation_url-input',
                'auto_fulfil' => 'auto_fulfil-input',
                'created_at' => 'created_at-input',
                'exit_uri' => 'exit_uri-input',
                'expires_at' => 'expires_at-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'lock_bank_account' => 'lock_bank_account-input',
                'lock_customer_details' => 'lock_customer_details-input',
                'redirect_uri' => 'redirect_uri-input',
                'session_token' => 'session_token-input',
              },
            }
          ).
          to_return(
            body: {
              'billing_request_flows' =>

                {

                  'authorisation_url' => 'authorisation_url-input',
                  'auto_fulfil' => 'auto_fulfil-input',
                  'created_at' => 'created_at-input',
                  'exit_uri' => 'exit_uri-input',
                  'expires_at' => 'expires_at-input',
                  'id' => 'id-input',
                  'links' => 'links-input',
                  'lock_bank_account' => 'lock_bank_account-input',
                  'lock_customer_details' => 'lock_customer_details-input',
                  'redirect_uri' => 'redirect_uri-input',
                  'session_token' => 'session_token-input',
                },

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::BillingRequestFlow)
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:post, %r{.*api.gocardless.com/billing_request_flows}).
                 to_timeout.then.to_return(status: 200, headers: response_headers)

          post_create_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:post, %r{.*api.gocardless.com/billing_request_flows}).
                 to_return(status: 502,
                           headers: { 'Content-Type' => 'text/html' },
                           body: '<html><body>Response from Cloudflare</body></html>').
                 then.to_return(status: 200, headers: response_headers)

          post_create_response
          expect(stub).to have_been_requested.twice
        end
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/billing_request_flows}).to_return(
          body: {
            error: {
              type: 'validation_failed',
              code: 422,
              errors: [
                { message: 'test error message', field: 'test_field' },
              ],
            },
          }.to_json,
          headers: response_headers,
          status: 422
        )
      end

      it 'throws the correct error' do
        expect { post_create_response }.to raise_error(GoCardlessPro::ValidationError)
      end
    end

    context 'with a request that returns an idempotent creation conflict error' do
      let(:id) { 'ID123' }

      let(:new_resource) do
        {

          'authorisation_url' => 'authorisation_url-input',
          'auto_fulfil' => 'auto_fulfil-input',
          'created_at' => 'created_at-input',
          'exit_uri' => 'exit_uri-input',
          'expires_at' => 'expires_at-input',
          'id' => 'id-input',
          'links' => 'links-input',
          'lock_bank_account' => 'lock_bank_account-input',
          'lock_customer_details' => 'lock_customer_details-input',
          'redirect_uri' => 'redirect_uri-input',
          'session_token' => 'session_token-input',
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/billing_request_flows}).to_return(
          body: {
            error: {
              type: 'invalid_state',
              code: 409,
              errors: [
                {
                  message: 'A resource has already been created with this idempotency key',
                  reason: 'idempotent_creation_conflict',
                  links: {
                    conflicting_resource_id: id,
                  },
                },
              ],
            },
          }.to_json,
          headers: response_headers,
          status: 409
        )
      end

      it 'raises an InvalidStateError' do
        expect { post_create_response }.to raise_error(GoCardlessPro::InvalidStateError)
        expect(post_stub).to have_been_requested
      end
    end
  end

  describe '#initialise' do
    subject(:post_response) { client.billing_request_flows.initialise(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /billing_request_flows/%v/actions/initialise
      stub_url = '/billing_request_flows/:identity/actions/initialise'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(

        body: {
          'billing_request_flows' => {

            'authorisation_url' => 'authorisation_url-input',
            'auto_fulfil' => 'auto_fulfil-input',
            'created_at' => 'created_at-input',
            'exit_uri' => 'exit_uri-input',
            'expires_at' => 'expires_at-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'lock_bank_account' => 'lock_bank_account-input',
            'lock_customer_details' => 'lock_customer_details-input',
            'redirect_uri' => 'redirect_uri-input',
            'session_token' => 'session_token-input',
          },
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::BillingRequestFlow)

      expect(stub).to have_been_requested
    end

    describe 'retry behaviour' do
      it "doesn't retry errors" do
        stub_url = '/billing_request_flows/:identity/actions/initialise'.gsub(':identity', resource_id)
        stub = stub_request(:post, /.*api.gocardless.com#{stub_url}/).
               to_timeout

        expect { post_response }.to raise_error(Faraday::ConnectionFailed)
        expect(stub).to have_been_requested
      end
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:post_response) { client.billing_request_flows.initialise(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /billing_request_flows/%v/actions/initialise
        stub_url = '/billing_request_flows/:identity/actions/initialise'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'billing_request_flows' => {

                'authorisation_url' => 'authorisation_url-input',
                'auto_fulfil' => 'auto_fulfil-input',
                'created_at' => 'created_at-input',
                'exit_uri' => 'exit_uri-input',
                'expires_at' => 'expires_at-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'lock_bank_account' => 'lock_bank_account-input',
                'lock_customer_details' => 'lock_customer_details-input',
                'redirect_uri' => 'redirect_uri-input',
                'session_token' => 'session_token-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
