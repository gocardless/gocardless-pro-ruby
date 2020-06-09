require 'spec_helper'

describe GoCardlessPro::Services::CustomerBankAccountsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.customer_bank_accounts.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'account_holder_name' => 'account_holder_name-input',
          'account_number_ending' => 'account_number_ending-input',
          'account_type' => 'account_type-input',
          'bank_name' => 'bank_name-input',
          'country_code' => 'country_code-input',
          'created_at' => 'created_at-input',
          'currency' => 'currency-input',
          'enabled' => 'enabled-input',
          'id' => 'id-input',
          'links' => 'links-input',
          'metadata' => 'metadata-input',
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/customer_bank_accounts}).
          with(
            body: {
              'customer_bank_accounts' => {

                'account_holder_name' => 'account_holder_name-input',
                'account_number_ending' => 'account_number_ending-input',
                'account_type' => 'account_type-input',
                'bank_name' => 'bank_name-input',
                'country_code' => 'country_code-input',
                'created_at' => 'created_at-input',
                'currency' => 'currency-input',
                'enabled' => 'enabled-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
              },
            }
          ).
          to_return(
            body: {
              'customer_bank_accounts' =>

                {

                  'account_holder_name' => 'account_holder_name-input',
                  'account_number_ending' => 'account_number_ending-input',
                  'account_type' => 'account_type-input',
                  'bank_name' => 'bank_name-input',
                  'country_code' => 'country_code-input',
                  'created_at' => 'created_at-input',
                  'currency' => 'currency-input',
                  'enabled' => 'enabled-input',
                  'id' => 'id-input',
                  'links' => 'links-input',
                  'metadata' => 'metadata-input',
                },

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::CustomerBankAccount)
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:post, %r{.*api.gocardless.com/customer_bank_accounts}).
                 to_timeout.then.to_return(status: 200, headers: response_headers)

          post_create_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:post, %r{.*api.gocardless.com/customer_bank_accounts}).
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
        stub_request(:post, %r{.*api.gocardless.com/customer_bank_accounts}).to_return(
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

          'account_holder_name' => 'account_holder_name-input',
          'account_number_ending' => 'account_number_ending-input',
          'account_type' => 'account_type-input',
          'bank_name' => 'bank_name-input',
          'country_code' => 'country_code-input',
          'created_at' => 'created_at-input',
          'currency' => 'currency-input',
          'enabled' => 'enabled-input',
          'id' => 'id-input',
          'links' => 'links-input',
          'metadata' => 'metadata-input',
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/customer_bank_accounts}).to_return(
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
        stub_url = "/customer_bank_accounts/#{id}"
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          to_return(
            body: {
              'customer_bank_accounts' => {

                'account_holder_name' => 'account_holder_name-input',
                'account_number_ending' => 'account_number_ending-input',
                'account_type' => 'account_type-input',
                'bank_name' => 'bank_name-input',
                'country_code' => 'country_code-input',
                'created_at' => 'created_at-input',
                'currency' => 'currency-input',
                'enabled' => 'enabled-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
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

      context 'with on_idempotency_conflict: :unknown' do
        let(:client) do
          GoCardlessPro::Client.new(
            access_token: 'SECRET_TOKEN',
            on_idempotency_conflict: :unknown
          )
        end

        it 'raises an ArgumentError' do
          expect { post_create_response }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.customer_bank_accounts.list }

      let(:body) do
        {
          'customer_bank_accounts' => [{

            'account_holder_name' => 'account_holder_name-input',
            'account_number_ending' => 'account_number_ending-input',
            'account_type' => 'account_type-input',
            'bank_name' => 'bank_name-input',
            'country_code' => 'country_code-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'enabled' => 'enabled-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
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
        stub_request(:get, %r{.*api.gocardless.com/customer_bank_accounts}).to_return(
          body: body,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map(&:class).uniq.first).to eq(GoCardlessPro::Resources::CustomerBankAccount)

        expect(get_list_response.records.first.account_holder_name).to eq('account_holder_name-input')

        expect(get_list_response.records.first.account_number_ending).to eq('account_number_ending-input')

        expect(get_list_response.records.first.account_type).to eq('account_type-input')

        expect(get_list_response.records.first.bank_name).to eq('bank_name-input')

        expect(get_list_response.records.first.country_code).to eq('country_code-input')

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.currency).to eq('currency-input')

        expect(get_list_response.records.first.enabled).to eq('enabled-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.metadata).to eq('metadata-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:get, %r{.*api.gocardless.com/customer_bank_accounts}).
                 to_timeout.then.to_return(status: 200, headers: response_headers, body: body)

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/customer_bank_accounts}).
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
      stub_request(:get, %r{.*api.gocardless.com/customer_bank_accounts$}).to_return(
        body: {
          'customer_bank_accounts' => [{

            'account_holder_name' => 'account_holder_name-input',
            'account_number_ending' => 'account_number_ending-input',
            'account_type' => 'account_type-input',
            'bank_name' => 'bank_name-input',
            'country_code' => 'country_code-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'enabled' => 'enabled-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
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
      stub_request(:get, %r{.*api.gocardless.com/customer_bank_accounts\?after=AB345}).to_return(
        body: {
          'customer_bank_accounts' => [{

            'account_holder_name' => 'account_holder_name-input',
            'account_number_ending' => 'account_number_ending-input',
            'account_type' => 'account_type-input',
            'bank_name' => 'bank_name-input',
            'country_code' => 'country_code-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'enabled' => 'enabled-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
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
      expect(client.customer_bank_accounts.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/customer_bank_accounts$}).to_return(
          body: {
            'customer_bank_accounts' => [{

              'account_holder_name' => 'account_holder_name-input',
              'account_number_ending' => 'account_number_ending-input',
              'account_type' => 'account_type-input',
              'bank_name' => 'bank_name-input',
              'country_code' => 'country_code-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'enabled' => 'enabled-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/customer_bank_accounts\?after=AB345}).
                               to_timeout.then.
                               to_return(
                                 body: {
                                   'customer_bank_accounts' => [{

                                     'account_holder_name' => 'account_holder_name-input',
                                     'account_number_ending' => 'account_number_ending-input',
                                     'account_type' => 'account_type-input',
                                     'bank_name' => 'bank_name-input',
                                     'country_code' => 'country_code-input',
                                     'created_at' => 'created_at-input',
                                     'currency' => 'currency-input',
                                     'enabled' => 'enabled-input',
                                     'id' => 'id-input',
                                     'links' => 'links-input',
                                     'metadata' => 'metadata-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.customer_bank_accounts.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/customer_bank_accounts$}).to_return(
          body: {
            'customer_bank_accounts' => [{

              'account_holder_name' => 'account_holder_name-input',
              'account_number_ending' => 'account_number_ending-input',
              'account_type' => 'account_type-input',
              'bank_name' => 'bank_name-input',
              'country_code' => 'country_code-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'enabled' => 'enabled-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/customer_bank_accounts\?after=AB345}).
                               to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
                                 body: {
                                   'customer_bank_accounts' => [{

                                     'account_holder_name' => 'account_holder_name-input',
                                     'account_number_ending' => 'account_number_ending-input',
                                     'account_type' => 'account_type-input',
                                     'bank_name' => 'bank_name-input',
                                     'country_code' => 'country_code-input',
                                     'created_at' => 'created_at-input',
                                     'currency' => 'currency-input',
                                     'enabled' => 'enabled-input',
                                     'id' => 'id-input',
                                     'links' => 'links-input',
                                     'metadata' => 'metadata-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.customer_bank_accounts.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
    end
  end

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.customer_bank_accounts.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/customer_bank_accounts/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              'customer_bank_accounts' => {

                'account_holder_name' => 'account_holder_name-input',
                'account_number_ending' => 'account_number_ending-input',
                'account_type' => 'account_type-input',
                'bank_name' => 'bank_name-input',
                'country_code' => 'country_code-input',
                'created_at' => 'created_at-input',
                'currency' => 'currency-input',
                'enabled' => 'enabled-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
              },
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.customer_bank_accounts.get(id, headers: {
                                            'Foo' => 'Bar',
                                          })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a customer_bank_account to return' do
      before do
        stub_url = '/customer_bank_accounts/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'customer_bank_accounts' => {

              'account_holder_name' => 'account_holder_name-input',
              'account_number_ending' => 'account_number_ending-input',
              'account_type' => 'account_type-input',
              'bank_name' => 'bank_name-input',
              'country_code' => 'country_code-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'enabled' => 'enabled-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::CustomerBankAccount)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/customer_bank_accounts/:identity'.gsub(':identity', id)
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
        stub_url = '/customer_bank_accounts/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_timeout.then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 5XX errors, other than 500s' do
        stub_url = '/customer_bank_accounts/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_return(status: 502,
                         headers: { 'Content-Type' => 'text/html' },
                         body: '<html><body>Response from Cloudflare</body></html>').
               then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 500 errors returned by the API' do
        stub_url = '/customer_bank_accounts/:identity'.gsub(':identity', id)

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

  describe '#update' do
    subject(:put_update_response) { client.customer_bank_accounts.update(id, params: update_params) }
    let(:id) { 'ABC123' }

    context 'with a valid request' do
      let(:update_params) { { 'hello' => 'world' } }

      let!(:stub) do
        stub_url = '/customer_bank_accounts/:identity'.gsub(':identity', id)
        stub_request(:put, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'customer_bank_accounts' => {

              'account_holder_name' => 'account_holder_name-input',
              'account_number_ending' => 'account_number_ending-input',
              'account_type' => 'account_type-input',
              'bank_name' => 'bank_name-input',
              'country_code' => 'country_code-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'enabled' => 'enabled-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'updates and returns the resource' do
        expect(put_update_response).to be_a(GoCardlessPro::Resources::CustomerBankAccount)
        expect(stub).to have_been_requested
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub_url = '/customer_bank_accounts/:identity'.gsub(':identity', id)
          stub = stub_request(:put, /.*api.gocardless.com#{stub_url}/).
                 to_timeout.then.to_return(status: 200, headers: response_headers)

          put_update_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub_url = '/customer_bank_accounts/:identity'.gsub(':identity', id)
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

  describe '#disable' do
    subject(:post_response) { client.customer_bank_accounts.disable(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /customer_bank_accounts/%v/actions/disable
      stub_url = '/customer_bank_accounts/:identity/actions/disable'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'customer_bank_accounts' => {

            'account_holder_name' => 'account_holder_name-input',
            'account_number_ending' => 'account_number_ending-input',
            'account_type' => 'account_type-input',
            'bank_name' => 'bank_name-input',
            'country_code' => 'country_code-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'enabled' => 'enabled-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
          },
        }.to_json,
        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::CustomerBankAccount)

      expect(stub).to have_been_requested
    end

    describe 'retry behaviour' do
      it "doesn't retry errors" do
        stub_url = '/customer_bank_accounts/:identity/actions/disable'.gsub(':identity', resource_id)
        stub = stub_request(:post, /.*api.gocardless.com#{stub_url}/).
               to_timeout

        expect { post_response }.to raise_error(Faraday::ConnectionFailed)
        expect(stub).to have_been_requested
      end
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:post_response) { client.customer_bank_accounts.disable(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /customer_bank_accounts/%v/actions/disable
        stub_url = '/customer_bank_accounts/:identity/actions/disable'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'customer_bank_accounts' => {

                'account_holder_name' => 'account_holder_name-input',
                'account_number_ending' => 'account_number_ending-input',
                'account_type' => 'account_type-input',
                'bank_name' => 'bank_name-input',
                'country_code' => 'country_code-input',
                'created_at' => 'created_at-input',
                'currency' => 'currency-input',
                'enabled' => 'enabled-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
