require 'spec_helper'

describe GoCardlessPro::Services::MandateImportEntriesService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.mandate_import_entries.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'created_at' => 'created_at-input',
          'links' => 'links-input',
          'record_identifier' => 'record_identifier-input',
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/mandate_import_entries}).
          with(
            body: {
              'mandate_import_entries' => {

                'created_at' => 'created_at-input',
                'links' => 'links-input',
                'record_identifier' => 'record_identifier-input',
              },
            }
          ).
          to_return(
            body: {
              'mandate_import_entries' =>

                {

                  'created_at' => 'created_at-input',
                  'links' => 'links-input',
                  'record_identifier' => 'record_identifier-input',
                },

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::MandateImportEntry)
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:post, %r{.*api.gocardless.com/mandate_import_entries}).
                 to_timeout.then.to_return({ status: 200, headers: response_headers })

          post_create_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:post, %r{.*api.gocardless.com/mandate_import_entries}).
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
        stub_request(:post, %r{.*api.gocardless.com/mandate_import_entries}).to_return(
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

          'created_at' => 'created_at-input',
          'links' => 'links-input',
          'record_identifier' => 'record_identifier-input',
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/mandate_import_entries}).to_return(
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

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.mandate_import_entries.list }

      let(:body) do
        {
          'mandate_import_entries' => [{

            'created_at' => 'created_at-input',
            'links' => 'links-input',
            'record_identifier' => 'record_identifier-input',
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
        stub_request(:get, %r{.*api.gocardless.com/mandate_import_entries}).to_return(
          body: body,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map do |x|
                 x.class
               end.uniq.first).to eq(GoCardlessPro::Resources::MandateImportEntry)

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.record_identifier).to eq('record_identifier-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:get, %r{.*api.gocardless.com/mandate_import_entries}).
                 to_timeout.then.to_return({ status: 200, headers: response_headers, body: body })

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/mandate_import_entries}).
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
      stub_request(:get, %r{.*api.gocardless.com/mandate_import_entries$}).to_return(
        body: {
          'mandate_import_entries' => [{

            'created_at' => 'created_at-input',
            'links' => 'links-input',
            'record_identifier' => 'record_identifier-input',
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
      stub_request(:get, %r{.*api.gocardless.com/mandate_import_entries\?after=AB345}).to_return(
        body: {
          'mandate_import_entries' => [{

            'created_at' => 'created_at-input',
            'links' => 'links-input',
            'record_identifier' => 'record_identifier-input',
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
      expect(client.mandate_import_entries.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/mandate_import_entries$}).to_return(
          body: {
            'mandate_import_entries' => [{

              'created_at' => 'created_at-input',
              'links' => 'links-input',
              'record_identifier' => 'record_identifier-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/mandate_import_entries\?after=AB345}).
                               to_timeout.then.
                               to_return(
                                 body: {
                                   'mandate_import_entries' => [{

                                     'created_at' => 'created_at-input',
                                     'links' => 'links-input',
                                     'record_identifier' => 'record_identifier-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.mandate_import_entries.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/mandate_import_entries$}).to_return(
          body: {
            'mandate_import_entries' => [{

              'created_at' => 'created_at-input',
              'links' => 'links-input',
              'record_identifier' => 'record_identifier-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/mandate_import_entries\?after=AB345}).
                               to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
                                 body: {
                                   'mandate_import_entries' => [{

                                     'created_at' => 'created_at-input',
                                     'links' => 'links-input',
                                     'record_identifier' => 'record_identifier-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.mandate_import_entries.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
    end
  end
end
