require 'spec_helper'

describe GoCardlessPro::Services::PayerAuthorisationsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.payer_authorisations.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/payer_authorisations/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              'payer_authorisations' => {

                'bank_account' => 'bank_account-input',
                'created_at' => 'created_at-input',
                'customer' => 'customer-input',
                'id' => 'id-input',
                'incomplete_fields' => 'incomplete_fields-input',
                'links' => 'links-input',
                'mandate' => 'mandate-input',
                'status' => 'status-input',
              },
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.payer_authorisations.get(id, headers: {
                                          'Foo' => 'Bar',
                                        })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a payer_authorisation to return' do
      before do
        stub_url = '/payer_authorisations/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'payer_authorisations' => {

              'bank_account' => 'bank_account-input',
              'created_at' => 'created_at-input',
              'customer' => 'customer-input',
              'id' => 'id-input',
              'incomplete_fields' => 'incomplete_fields-input',
              'links' => 'links-input',
              'mandate' => 'mandate-input',
              'status' => 'status-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::PayerAuthorisation)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/payer_authorisations/:identity'.gsub(':identity', id)
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

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        stub_url = '/payer_authorisations/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_timeout.then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 5XX errors, other than 500s' do
        stub_url = '/payer_authorisations/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_return(status: 502,
                         headers: { 'Content-Type' => 'text/html' },
                         body: '<html><body>Response from Cloudflare</body></html>').
               then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 500 errors returned by the API' do
        stub_url = '/payer_authorisations/:identity'.gsub(':identity', id)

        gocardless_error = {
          'error' => {
            'message' => 'Internal server error',
            'documentation_url' => 'https://developer.gocardless.com/#gocardless',
            'errors' => [{
              'message' => 'Internal server error',
              'reason' => 'internal_server_error',
            }],
            'type' => 'gocardless',
            'code' => 500,
            'request_id' => 'dummy_request_id',
            'id' => 'dummy_exception_id',
          },
        }

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_return(status: 500,
                         headers: response_headers,
                         body: gocardless_error.to_json).
               then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end
    end
  end

  describe '#create' do
    subject(:post_create_response) { client.payer_authorisations.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'bank_account' => 'bank_account-input',
          'created_at' => 'created_at-input',
          'customer' => 'customer-input',
          'id' => 'id-input',
          'incomplete_fields' => 'incomplete_fields-input',
          'links' => 'links-input',
          'mandate' => 'mandate-input',
          'status' => 'status-input',
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/payer_authorisations}).
          with(
            body: {
              'payer_authorisations' => {

                'bank_account' => 'bank_account-input',
                'created_at' => 'created_at-input',
                'customer' => 'customer-input',
                'id' => 'id-input',
                'incomplete_fields' => 'incomplete_fields-input',
                'links' => 'links-input',
                'mandate' => 'mandate-input',
                'status' => 'status-input',
              },
            }
          ).
          to_return(
            body: {
              'payer_authorisations' =>

                {

                  'bank_account' => 'bank_account-input',
                  'created_at' => 'created_at-input',
                  'customer' => 'customer-input',
                  'id' => 'id-input',
                  'incomplete_fields' => 'incomplete_fields-input',
                  'links' => 'links-input',
                  'mandate' => 'mandate-input',
                  'status' => 'status-input',
                },

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::PayerAuthorisation)
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:post, %r{.*api.gocardless.com/payer_authorisations}).
                 to_timeout.then.to_return(status: 200, headers: response_headers)

          post_create_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:post, %r{.*api.gocardless.com/payer_authorisations}).
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
        stub_request(:post, %r{.*api.gocardless.com/payer_authorisations}).to_return(
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

          'bank_account' => 'bank_account-input',
          'created_at' => 'created_at-input',
          'customer' => 'customer-input',
          'id' => 'id-input',
          'incomplete_fields' => 'incomplete_fields-input',
          'links' => 'links-input',
          'mandate' => 'mandate-input',
          'status' => 'status-input',
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/payer_authorisations}).to_return(
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

      let!(:get_stub) do
        stub_url = "/payer_authorisations/#{id}"
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          to_return(
            body: {
              'payer_authorisations' => {

                'bank_account' => 'bank_account-input',
                'created_at' => 'created_at-input',
                'customer' => 'customer-input',
                'id' => 'id-input',
                'incomplete_fields' => 'incomplete_fields-input',
                'links' => 'links-input',
                'mandate' => 'mandate-input',
                'status' => 'status-input',
              },
            }.to_json,
            headers: response_headers
          )
      end

      context 'with default behaviour' do
        it 'fetches the already-created resource' do
          post_create_response
          expect(post_stub).to have_been_requested
          expect(get_stub).to have_been_requested
        end
      end

      context 'with on_idempotency_conflict: :raise' do
        let(:client) do
          GoCardlessPro::Client.new(
            access_token: 'SECRET_TOKEN',
            on_idempotency_conflict: :raise
          )
        end

        it 'raises an IdempotencyConflict error' do
          expect { post_create_response }.
            to raise_error(GoCardlessPro::IdempotencyConflict)
        end
      end
    end
  end

  describe '#update' do
    subject(:put_update_response) { client.payer_authorisations.update(id, params: update_params) }
    let(:id) { 'ABC123' }

    context 'with a valid request' do
      let(:update_params) { { 'hello' => 'world' } }

      let!(:stub) do
        stub_url = '/payer_authorisations/:identity'.gsub(':identity', id)
        stub_request(:put, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'payer_authorisations' => {

              'bank_account' => 'bank_account-input',
              'created_at' => 'created_at-input',
              'customer' => 'customer-input',
              'id' => 'id-input',
              'incomplete_fields' => 'incomplete_fields-input',
              'links' => 'links-input',
              'mandate' => 'mandate-input',
              'status' => 'status-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'updates and returns the resource' do
        expect(put_update_response).to be_a(GoCardlessPro::Resources::PayerAuthorisation)
        expect(stub).to have_been_requested
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub_url = '/payer_authorisations/:identity'.gsub(':identity', id)
          stub = stub_request(:put, /.*api.gocardless.com#{stub_url}/).
                 to_timeout.then.to_return(status: 200, headers: response_headers)

          put_update_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub_url = '/payer_authorisations/:identity'.gsub(':identity', id)
          stub = stub_request(:put, /.*api.gocardless.com#{stub_url}/).
                 to_return(status: 502,
                           headers: { 'Content-Type' => 'text/html' },
                           body: '<html><body>Response from Cloudflare</body></html>').
                 then.to_return(status: 200, headers: response_headers)

          put_update_response
          expect(stub).to have_been_requested.twice
        end
      end
    end
  end

  describe '#submit' do
    subject(:post_response) { client.payer_authorisations.submit(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /payer_authorisations/%v/actions/submit
      stub_url = '/payer_authorisations/:identity/actions/submit'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'payer_authorisations' => {

            'bank_account' => 'bank_account-input',
            'created_at' => 'created_at-input',
            'customer' => 'customer-input',
            'id' => 'id-input',
            'incomplete_fields' => 'incomplete_fields-input',
            'links' => 'links-input',
            'mandate' => 'mandate-input',
            'status' => 'status-input',
          },
        }.to_json,
        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::PayerAuthorisation)

      expect(stub).to have_been_requested
    end

    describe 'retry behaviour' do
      it "doesn't retry errors" do
        stub_url = '/payer_authorisations/:identity/actions/submit'.gsub(':identity', resource_id)
        stub = stub_request(:post, /.*api.gocardless.com#{stub_url}/).
               to_timeout

        expect { post_response }.to raise_error(Faraday::ConnectionFailed)
        expect(stub).to have_been_requested
      end
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:post_response) { client.payer_authorisations.submit(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /payer_authorisations/%v/actions/submit
        stub_url = '/payer_authorisations/:identity/actions/submit'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'payer_authorisations' => {

                'bank_account' => 'bank_account-input',
                'created_at' => 'created_at-input',
                'customer' => 'customer-input',
                'id' => 'id-input',
                'incomplete_fields' => 'incomplete_fields-input',
                'links' => 'links-input',
                'mandate' => 'mandate-input',
                'status' => 'status-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end

  describe '#confirm' do
    subject(:post_response) { client.payer_authorisations.confirm(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /payer_authorisations/%v/actions/confirm
      stub_url = '/payer_authorisations/:identity/actions/confirm'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'payer_authorisations' => {

            'bank_account' => 'bank_account-input',
            'created_at' => 'created_at-input',
            'customer' => 'customer-input',
            'id' => 'id-input',
            'incomplete_fields' => 'incomplete_fields-input',
            'links' => 'links-input',
            'mandate' => 'mandate-input',
            'status' => 'status-input',
          },
        }.to_json,
        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::PayerAuthorisation)

      expect(stub).to have_been_requested
    end

    describe 'retry behaviour' do
      it "doesn't retry errors" do
        stub_url = '/payer_authorisations/:identity/actions/confirm'.gsub(':identity', resource_id)
        stub = stub_request(:post, /.*api.gocardless.com#{stub_url}/).
               to_timeout

        expect { post_response }.to raise_error(Faraday::ConnectionFailed)
        expect(stub).to have_been_requested
      end
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:post_response) { client.payer_authorisations.confirm(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /payer_authorisations/%v/actions/confirm
        stub_url = '/payer_authorisations/:identity/actions/confirm'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'payer_authorisations' => {

                'bank_account' => 'bank_account-input',
                'created_at' => 'created_at-input',
                'customer' => 'customer-input',
                'id' => 'id-input',
                'incomplete_fields' => 'incomplete_fields-input',
                'links' => 'links-input',
                'mandate' => 'mandate-input',
                'status' => 'status-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
