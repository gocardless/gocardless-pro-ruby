require 'spec_helper'

describe GoCardlessPro::Resources::BankAuthorisation do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.bank_authorisations.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/bank_authorisations/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              'bank_authorisations' => {

                'authorisation_type' => 'authorisation_type-input',
                'authorised_at' => 'authorised_at-input',
                'created_at' => 'created_at-input',
                'expires_at' => 'expires_at-input',
                'id' => 'id-input',
                'last_visited_at' => 'last_visited_at-input',
                'links' => 'links-input',
                'redirect_uri' => 'redirect_uri-input',
                'url' => 'url-input',
              },
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.bank_authorisations.get(id, headers: {
                                         'Foo' => 'Bar',
                                       })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a bank_authorisation to return' do
      before do
        stub_url = '/bank_authorisations/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'bank_authorisations' => {

              'authorisation_type' => 'authorisation_type-input',
              'authorised_at' => 'authorised_at-input',
              'created_at' => 'created_at-input',
              'expires_at' => 'expires_at-input',
              'id' => 'id-input',
              'last_visited_at' => 'last_visited_at-input',
              'links' => 'links-input',
              'redirect_uri' => 'redirect_uri-input',
              'url' => 'url-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::BankAuthorisation)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/bank_authorisations/:identity'.gsub(':identity', id)
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
  end

  describe '#create' do
    subject(:post_create_response) { client.bank_authorisations.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'authorisation_type' => 'authorisation_type-input',
          'authorised_at' => 'authorised_at-input',
          'created_at' => 'created_at-input',
          'expires_at' => 'expires_at-input',
          'id' => 'id-input',
          'last_visited_at' => 'last_visited_at-input',
          'links' => 'links-input',
          'redirect_uri' => 'redirect_uri-input',
          'url' => 'url-input',
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/bank_authorisations}).
          with(
            body: {
              'bank_authorisations' => {

                'authorisation_type' => 'authorisation_type-input',
                'authorised_at' => 'authorised_at-input',
                'created_at' => 'created_at-input',
                'expires_at' => 'expires_at-input',
                'id' => 'id-input',
                'last_visited_at' => 'last_visited_at-input',
                'links' => 'links-input',
                'redirect_uri' => 'redirect_uri-input',
                'url' => 'url-input',
              },
            }
          ).
          to_return(
            body: {
              'bank_authorisations' =>

                {

                  'authorisation_type' => 'authorisation_type-input',
                  'authorised_at' => 'authorised_at-input',
                  'created_at' => 'created_at-input',
                  'expires_at' => 'expires_at-input',
                  'id' => 'id-input',
                  'last_visited_at' => 'last_visited_at-input',
                  'links' => 'links-input',
                  'redirect_uri' => 'redirect_uri-input',
                  'url' => 'url-input',
                },

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::BankAuthorisation)
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/bank_authorisations}).to_return(
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

          'authorisation_type' => 'authorisation_type-input',
          'authorised_at' => 'authorised_at-input',
          'created_at' => 'created_at-input',
          'expires_at' => 'expires_at-input',
          'id' => 'id-input',
          'last_visited_at' => 'last_visited_at-input',
          'links' => 'links-input',
          'redirect_uri' => 'redirect_uri-input',
          'url' => 'url-input',
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/bank_authorisations}).to_return(
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
        stub_url = "/bank_authorisations/#{id}"
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          to_return(
            body: {
              'bank_authorisations' => {

                'authorisation_type' => 'authorisation_type-input',
                'authorised_at' => 'authorised_at-input',
                'created_at' => 'created_at-input',
                'expires_at' => 'expires_at-input',
                'id' => 'id-input',
                'last_visited_at' => 'last_visited_at-input',
                'links' => 'links-input',
                'redirect_uri' => 'redirect_uri-input',
                'url' => 'url-input',
              },
            }.to_json,
            headers: response_headers
          )
      end

      it 'fetches the already-created resource' do
        post_create_response
        expect(post_stub).to have_been_requested
        expect(get_stub).to have_been_requested
      end
    end
  end
end
