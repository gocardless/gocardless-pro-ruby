require 'spec_helper'

describe GoCardlessPro::Services::BankDetailsLookupsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.bank_details_lookups.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'available_debit_schemes' => 'available_debit_schemes-input',
          'bank_name' => 'bank_name-input',
          'bic' => 'bic-input'
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/bank_details_lookups})
          .with(
            body: {
              'bank_details_lookups' => {

                'available_debit_schemes' => 'available_debit_schemes-input',
                'bank_name' => 'bank_name-input',
                'bic' => 'bic-input'
              }
            }
          )
          .to_return(
            body: {
              'bank_details_lookups' =>

                {

                  'available_debit_schemes' => 'available_debit_schemes-input',
                  'bank_name' => 'bank_name-input',
                  'bic' => 'bic-input'
                }

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::BankDetailsLookup)
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:post, %r{.*api.gocardless.com/bank_details_lookups})
                 .to_timeout.then.to_return({ status: 200, headers: response_headers })

          post_create_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:post, %r{.*api.gocardless.com/bank_details_lookups})
                 .to_return({ status: 502,
                              headers: { 'Content-Type' => 'text/html' },
                              body: '<html><body>Response from Cloudflare</body></html>' })
                 .then.to_return({ status: 200, headers: response_headers })

          post_create_response
          expect(stub).to have_been_requested.twice
        end
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/bank_details_lookups}).to_return(
          body: {
            error: {
              type: 'validation_failed',
              code: 422,
              errors: [
                { message: 'test error message', field: 'test_field' }
              ]
            }
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

          'available_debit_schemes' => 'available_debit_schemes-input',
          'bank_name' => 'bank_name-input',
          'bic' => 'bic-input'
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/bank_details_lookups}).to_return(
          body: {
            error: {
              type: 'invalid_state',
              code: 409,
              errors: [
                {
                  message: 'A resource has already been created with this idempotency key',
                  reason: 'idempotent_creation_conflict',
                  links: {
                    conflicting_resource_id: id
                  }
                }
              ]
            }
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
end
