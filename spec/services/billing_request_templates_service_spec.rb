require 'spec_helper'

describe GoCardlessPro::Services::BillingRequestTemplatesService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.billing_request_templates.list }

      let(:body) do
        {
          'billing_request_templates' => [{

            'authorisation_url' => 'authorisation_url-input',
            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'mandate_request_currency' => 'mandate_request_currency-input',
            'mandate_request_description' => 'mandate_request_description-input',
            'mandate_request_metadata' => 'mandate_request_metadata-input',
            'mandate_request_scheme' => 'mandate_request_scheme-input',
            'mandate_request_verify' => 'mandate_request_verify-input',
            'metadata' => 'metadata-input',
            'name' => 'name-input',
            'payment_request_amount' => 'payment_request_amount-input',
            'payment_request_currency' => 'payment_request_currency-input',
            'payment_request_description' => 'payment_request_description-input',
            'payment_request_metadata' => 'payment_request_metadata-input',
            'payment_request_scheme' => 'payment_request_scheme-input',
            'redirect_uri' => 'redirect_uri-input',
            'updated_at' => 'updated_at-input',
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
        stub_request(:get, %r{.*api.gocardless.com/billing_request_templates}).to_return(
          body: body,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map do |x|
                 x.class
               end.uniq.first).to eq(GoCardlessPro::Resources::BillingRequestTemplate)

        expect(get_list_response.records.first.authorisation_url).to eq('authorisation_url-input')

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.mandate_request_currency).to eq('mandate_request_currency-input')

        expect(get_list_response.records.first.mandate_request_description).to eq('mandate_request_description-input')

        expect(get_list_response.records.first.mandate_request_metadata).to eq('mandate_request_metadata-input')

        expect(get_list_response.records.first.mandate_request_scheme).to eq('mandate_request_scheme-input')

        expect(get_list_response.records.first.mandate_request_verify).to eq('mandate_request_verify-input')

        expect(get_list_response.records.first.metadata).to eq('metadata-input')

        expect(get_list_response.records.first.name).to eq('name-input')

        expect(get_list_response.records.first.payment_request_amount).to eq('payment_request_amount-input')

        expect(get_list_response.records.first.payment_request_currency).to eq('payment_request_currency-input')

        expect(get_list_response.records.first.payment_request_description).to eq('payment_request_description-input')

        expect(get_list_response.records.first.payment_request_metadata).to eq('payment_request_metadata-input')

        expect(get_list_response.records.first.payment_request_scheme).to eq('payment_request_scheme-input')

        expect(get_list_response.records.first.redirect_uri).to eq('redirect_uri-input')

        expect(get_list_response.records.first.updated_at).to eq('updated_at-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:get, %r{.*api.gocardless.com/billing_request_templates}).
                 to_timeout.then.to_return({ status: 200, headers: response_headers, body: body })

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/billing_request_templates}).
                 to_return({ status: 502,
                             headers: { 'Content-Type' => 'text/html' },
                             body: '<html><body>Response from Cloudflare</body></html>' }).
                 then.to_return({ status: 200, headers: response_headers, body: body })

          get_list_response
          expect(stub).to have_been_requested.twice
        end
      end
    end
  end

  describe '#all' do
    let!(:first_response_stub) do
      stub_request(:get, %r{.*api.gocardless.com/billing_request_templates$}).to_return(
        body: {
          'billing_request_templates' => [{

            'authorisation_url' => 'authorisation_url-input',
            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'mandate_request_currency' => 'mandate_request_currency-input',
            'mandate_request_description' => 'mandate_request_description-input',
            'mandate_request_metadata' => 'mandate_request_metadata-input',
            'mandate_request_scheme' => 'mandate_request_scheme-input',
            'mandate_request_verify' => 'mandate_request_verify-input',
            'metadata' => 'metadata-input',
            'name' => 'name-input',
            'payment_request_amount' => 'payment_request_amount-input',
            'payment_request_currency' => 'payment_request_currency-input',
            'payment_request_description' => 'payment_request_description-input',
            'payment_request_metadata' => 'payment_request_metadata-input',
            'payment_request_scheme' => 'payment_request_scheme-input',
            'redirect_uri' => 'redirect_uri-input',
            'updated_at' => 'updated_at-input',
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
      stub_request(:get, %r{.*api.gocardless.com/billing_request_templates\?after=AB345}).to_return(
        body: {
          'billing_request_templates' => [{

            'authorisation_url' => 'authorisation_url-input',
            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'mandate_request_currency' => 'mandate_request_currency-input',
            'mandate_request_description' => 'mandate_request_description-input',
            'mandate_request_metadata' => 'mandate_request_metadata-input',
            'mandate_request_scheme' => 'mandate_request_scheme-input',
            'mandate_request_verify' => 'mandate_request_verify-input',
            'metadata' => 'metadata-input',
            'name' => 'name-input',
            'payment_request_amount' => 'payment_request_amount-input',
            'payment_request_currency' => 'payment_request_currency-input',
            'payment_request_description' => 'payment_request_description-input',
            'payment_request_metadata' => 'payment_request_metadata-input',
            'payment_request_scheme' => 'payment_request_scheme-input',
            'redirect_uri' => 'redirect_uri-input',
            'updated_at' => 'updated_at-input',
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
      expect(client.billing_request_templates.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/billing_request_templates$}).to_return(
          body: {
            'billing_request_templates' => [{

              'authorisation_url' => 'authorisation_url-input',
              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'mandate_request_currency' => 'mandate_request_currency-input',
              'mandate_request_description' => 'mandate_request_description-input',
              'mandate_request_metadata' => 'mandate_request_metadata-input',
              'mandate_request_scheme' => 'mandate_request_scheme-input',
              'mandate_request_verify' => 'mandate_request_verify-input',
              'metadata' => 'metadata-input',
              'name' => 'name-input',
              'payment_request_amount' => 'payment_request_amount-input',
              'payment_request_currency' => 'payment_request_currency-input',
              'payment_request_description' => 'payment_request_description-input',
              'payment_request_metadata' => 'payment_request_metadata-input',
              'payment_request_scheme' => 'payment_request_scheme-input',
              'redirect_uri' => 'redirect_uri-input',
              'updated_at' => 'updated_at-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/billing_request_templates\?after=AB345}).
                               to_timeout.then.
                               to_return(
                                 body: {
                                   'billing_request_templates' => [{

                                     'authorisation_url' => 'authorisation_url-input',
                                     'created_at' => 'created_at-input',
                                     'id' => 'id-input',
                                     'mandate_request_currency' => 'mandate_request_currency-input',
                                     'mandate_request_description' => 'mandate_request_description-input',
                                     'mandate_request_metadata' => 'mandate_request_metadata-input',
                                     'mandate_request_scheme' => 'mandate_request_scheme-input',
                                     'mandate_request_verify' => 'mandate_request_verify-input',
                                     'metadata' => 'metadata-input',
                                     'name' => 'name-input',
                                     'payment_request_amount' => 'payment_request_amount-input',
                                     'payment_request_currency' => 'payment_request_currency-input',
                                     'payment_request_description' => 'payment_request_description-input',
                                     'payment_request_metadata' => 'payment_request_metadata-input',
                                     'payment_request_scheme' => 'payment_request_scheme-input',
                                     'redirect_uri' => 'redirect_uri-input',
                                     'updated_at' => 'updated_at-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.billing_request_templates.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/billing_request_templates$}).to_return(
          body: {
            'billing_request_templates' => [{

              'authorisation_url' => 'authorisation_url-input',
              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'mandate_request_currency' => 'mandate_request_currency-input',
              'mandate_request_description' => 'mandate_request_description-input',
              'mandate_request_metadata' => 'mandate_request_metadata-input',
              'mandate_request_scheme' => 'mandate_request_scheme-input',
              'mandate_request_verify' => 'mandate_request_verify-input',
              'metadata' => 'metadata-input',
              'name' => 'name-input',
              'payment_request_amount' => 'payment_request_amount-input',
              'payment_request_currency' => 'payment_request_currency-input',
              'payment_request_description' => 'payment_request_description-input',
              'payment_request_metadata' => 'payment_request_metadata-input',
              'payment_request_scheme' => 'payment_request_scheme-input',
              'redirect_uri' => 'redirect_uri-input',
              'updated_at' => 'updated_at-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/billing_request_templates\?after=AB345}).
                               to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
                                 body: {
                                   'billing_request_templates' => [{

                                     'authorisation_url' => 'authorisation_url-input',
                                     'created_at' => 'created_at-input',
                                     'id' => 'id-input',
                                     'mandate_request_currency' => 'mandate_request_currency-input',
                                     'mandate_request_description' => 'mandate_request_description-input',
                                     'mandate_request_metadata' => 'mandate_request_metadata-input',
                                     'mandate_request_scheme' => 'mandate_request_scheme-input',
                                     'mandate_request_verify' => 'mandate_request_verify-input',
                                     'metadata' => 'metadata-input',
                                     'name' => 'name-input',
                                     'payment_request_amount' => 'payment_request_amount-input',
                                     'payment_request_currency' => 'payment_request_currency-input',
                                     'payment_request_description' => 'payment_request_description-input',
                                     'payment_request_metadata' => 'payment_request_metadata-input',
                                     'payment_request_scheme' => 'payment_request_scheme-input',
                                     'redirect_uri' => 'redirect_uri-input',
                                     'updated_at' => 'updated_at-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.billing_request_templates.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
    end
  end

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.billing_request_templates.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/billing_request_templates/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              'billing_request_templates' => {

                'authorisation_url' => 'authorisation_url-input',
                'created_at' => 'created_at-input',
                'id' => 'id-input',
                'mandate_request_currency' => 'mandate_request_currency-input',
                'mandate_request_description' => 'mandate_request_description-input',
                'mandate_request_metadata' => 'mandate_request_metadata-input',
                'mandate_request_scheme' => 'mandate_request_scheme-input',
                'mandate_request_verify' => 'mandate_request_verify-input',
                'metadata' => 'metadata-input',
                'name' => 'name-input',
                'payment_request_amount' => 'payment_request_amount-input',
                'payment_request_currency' => 'payment_request_currency-input',
                'payment_request_description' => 'payment_request_description-input',
                'payment_request_metadata' => 'payment_request_metadata-input',
                'payment_request_scheme' => 'payment_request_scheme-input',
                'redirect_uri' => 'redirect_uri-input',
                'updated_at' => 'updated_at-input',
              },
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.billing_request_templates.get(id, headers: {
                                               'Foo' => 'Bar',
                                             })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a billing_request_template to return' do
      before do
        stub_url = '/billing_request_templates/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'billing_request_templates' => {

              'authorisation_url' => 'authorisation_url-input',
              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'mandate_request_currency' => 'mandate_request_currency-input',
              'mandate_request_description' => 'mandate_request_description-input',
              'mandate_request_metadata' => 'mandate_request_metadata-input',
              'mandate_request_scheme' => 'mandate_request_scheme-input',
              'mandate_request_verify' => 'mandate_request_verify-input',
              'metadata' => 'metadata-input',
              'name' => 'name-input',
              'payment_request_amount' => 'payment_request_amount-input',
              'payment_request_currency' => 'payment_request_currency-input',
              'payment_request_description' => 'payment_request_description-input',
              'payment_request_metadata' => 'payment_request_metadata-input',
              'payment_request_scheme' => 'payment_request_scheme-input',
              'redirect_uri' => 'redirect_uri-input',
              'updated_at' => 'updated_at-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::BillingRequestTemplate)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/billing_request_templates/:identity'.gsub(':identity', id)
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
        stub_url = '/billing_request_templates/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_timeout.then.to_return({ status: 200, headers: response_headers })

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 5XX errors, other than 500s' do
        stub_url = '/billing_request_templates/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_return({ status: 502,
                           headers: { 'Content-Type' => 'text/html' },
                           body: '<html><body>Response from Cloudflare</body></html>' }).
               then.to_return({ status: 200, headers: response_headers })

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 500 errors returned by the API' do
        stub_url = '/billing_request_templates/:identity'.gsub(':identity', id)

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
               to_return({ status: 500,
                           headers: response_headers,
                           body: gocardless_error.to_json }).
               then.to_return({ status: 200, headers: response_headers })

        get_response
        expect(stub).to have_been_requested.twice
      end
    end
  end

  describe '#create' do
    subject(:post_create_response) { client.billing_request_templates.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'authorisation_url' => 'authorisation_url-input',
          'created_at' => 'created_at-input',
          'id' => 'id-input',
          'mandate_request_currency' => 'mandate_request_currency-input',
          'mandate_request_description' => 'mandate_request_description-input',
          'mandate_request_metadata' => 'mandate_request_metadata-input',
          'mandate_request_scheme' => 'mandate_request_scheme-input',
          'mandate_request_verify' => 'mandate_request_verify-input',
          'metadata' => 'metadata-input',
          'name' => 'name-input',
          'payment_request_amount' => 'payment_request_amount-input',
          'payment_request_currency' => 'payment_request_currency-input',
          'payment_request_description' => 'payment_request_description-input',
          'payment_request_metadata' => 'payment_request_metadata-input',
          'payment_request_scheme' => 'payment_request_scheme-input',
          'redirect_uri' => 'redirect_uri-input',
          'updated_at' => 'updated_at-input',
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/billing_request_templates}).
          with(
            body: {
              'billing_request_templates' => {

                'authorisation_url' => 'authorisation_url-input',
                'created_at' => 'created_at-input',
                'id' => 'id-input',
                'mandate_request_currency' => 'mandate_request_currency-input',
                'mandate_request_description' => 'mandate_request_description-input',
                'mandate_request_metadata' => 'mandate_request_metadata-input',
                'mandate_request_scheme' => 'mandate_request_scheme-input',
                'mandate_request_verify' => 'mandate_request_verify-input',
                'metadata' => 'metadata-input',
                'name' => 'name-input',
                'payment_request_amount' => 'payment_request_amount-input',
                'payment_request_currency' => 'payment_request_currency-input',
                'payment_request_description' => 'payment_request_description-input',
                'payment_request_metadata' => 'payment_request_metadata-input',
                'payment_request_scheme' => 'payment_request_scheme-input',
                'redirect_uri' => 'redirect_uri-input',
                'updated_at' => 'updated_at-input',
              },
            }
          ).
          to_return(
            body: {
              'billing_request_templates' =>

                {

                  'authorisation_url' => 'authorisation_url-input',
                  'created_at' => 'created_at-input',
                  'id' => 'id-input',
                  'mandate_request_currency' => 'mandate_request_currency-input',
                  'mandate_request_description' => 'mandate_request_description-input',
                  'mandate_request_metadata' => 'mandate_request_metadata-input',
                  'mandate_request_scheme' => 'mandate_request_scheme-input',
                  'mandate_request_verify' => 'mandate_request_verify-input',
                  'metadata' => 'metadata-input',
                  'name' => 'name-input',
                  'payment_request_amount' => 'payment_request_amount-input',
                  'payment_request_currency' => 'payment_request_currency-input',
                  'payment_request_description' => 'payment_request_description-input',
                  'payment_request_metadata' => 'payment_request_metadata-input',
                  'payment_request_scheme' => 'payment_request_scheme-input',
                  'redirect_uri' => 'redirect_uri-input',
                  'updated_at' => 'updated_at-input',
                },

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::BillingRequestTemplate)
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:post, %r{.*api.gocardless.com/billing_request_templates}).
                 to_timeout.then.to_return({ status: 200, headers: response_headers })

          post_create_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:post, %r{.*api.gocardless.com/billing_request_templates}).
                 to_return({ status: 502,
                             headers: { 'Content-Type' => 'text/html' },
                             body: '<html><body>Response from Cloudflare</body></html>' }).
                 then.to_return({ status: 200, headers: response_headers })

          post_create_response
          expect(stub).to have_been_requested.twice
        end
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/billing_request_templates}).to_return(
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
          'created_at' => 'created_at-input',
          'id' => 'id-input',
          'mandate_request_currency' => 'mandate_request_currency-input',
          'mandate_request_description' => 'mandate_request_description-input',
          'mandate_request_metadata' => 'mandate_request_metadata-input',
          'mandate_request_scheme' => 'mandate_request_scheme-input',
          'mandate_request_verify' => 'mandate_request_verify-input',
          'metadata' => 'metadata-input',
          'name' => 'name-input',
          'payment_request_amount' => 'payment_request_amount-input',
          'payment_request_currency' => 'payment_request_currency-input',
          'payment_request_description' => 'payment_request_description-input',
          'payment_request_metadata' => 'payment_request_metadata-input',
          'payment_request_scheme' => 'payment_request_scheme-input',
          'redirect_uri' => 'redirect_uri-input',
          'updated_at' => 'updated_at-input',
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/billing_request_templates}).to_return(
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
        stub_url = "/billing_request_templates/#{id}"
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          to_return(
            body: {
              'billing_request_templates' => {

                'authorisation_url' => 'authorisation_url-input',
                'created_at' => 'created_at-input',
                'id' => 'id-input',
                'mandate_request_currency' => 'mandate_request_currency-input',
                'mandate_request_description' => 'mandate_request_description-input',
                'mandate_request_metadata' => 'mandate_request_metadata-input',
                'mandate_request_scheme' => 'mandate_request_scheme-input',
                'mandate_request_verify' => 'mandate_request_verify-input',
                'metadata' => 'metadata-input',
                'name' => 'name-input',
                'payment_request_amount' => 'payment_request_amount-input',
                'payment_request_currency' => 'payment_request_currency-input',
                'payment_request_description' => 'payment_request_description-input',
                'payment_request_metadata' => 'payment_request_metadata-input',
                'payment_request_scheme' => 'payment_request_scheme-input',
                'redirect_uri' => 'redirect_uri-input',
                'updated_at' => 'updated_at-input',
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
    subject(:put_update_response) { client.billing_request_templates.update(id, params: update_params) }
    let(:id) { 'ABC123' }

    context 'with a valid request' do
      let(:update_params) { { 'hello' => 'world' } }

      let!(:stub) do
        stub_url = '/billing_request_templates/:identity'.gsub(':identity', id)
        stub_request(:put, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'billing_request_templates' => {

              'authorisation_url' => 'authorisation_url-input',
              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'mandate_request_currency' => 'mandate_request_currency-input',
              'mandate_request_description' => 'mandate_request_description-input',
              'mandate_request_metadata' => 'mandate_request_metadata-input',
              'mandate_request_scheme' => 'mandate_request_scheme-input',
              'mandate_request_verify' => 'mandate_request_verify-input',
              'metadata' => 'metadata-input',
              'name' => 'name-input',
              'payment_request_amount' => 'payment_request_amount-input',
              'payment_request_currency' => 'payment_request_currency-input',
              'payment_request_description' => 'payment_request_description-input',
              'payment_request_metadata' => 'payment_request_metadata-input',
              'payment_request_scheme' => 'payment_request_scheme-input',
              'redirect_uri' => 'redirect_uri-input',
              'updated_at' => 'updated_at-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'updates and returns the resource' do
        expect(put_update_response).to be_a(GoCardlessPro::Resources::BillingRequestTemplate)
        expect(stub).to have_been_requested
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub_url = '/billing_request_templates/:identity'.gsub(':identity', id)
          stub = stub_request(:put, /.*api.gocardless.com#{stub_url}/).
                 to_timeout.then.to_return({ status: 200, headers: response_headers })

          put_update_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub_url = '/billing_request_templates/:identity'.gsub(':identity', id)
          stub = stub_request(:put, /.*api.gocardless.com#{stub_url}/).
                 to_return({ status: 502,
                             headers: { 'Content-Type' => 'text/html' },
                             body: '<html><body>Response from Cloudflare</body></html>' }).
                 then.to_return({ status: 200, headers: response_headers })

          put_update_response
          expect(stub).to have_been_requested.twice
        end
      end
    end
  end
end
