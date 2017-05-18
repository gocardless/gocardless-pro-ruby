require 'spec_helper'

describe GoCardlessPro::Resources::Creditor do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.creditors.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'address_line1' => 'address_line1-input',
          'address_line2' => 'address_line2-input',
          'address_line3' => 'address_line3-input',
          'city' => 'city-input',
          'country_code' => 'country_code-input',
          'created_at' => 'created_at-input',
          'id' => 'id-input',
          'links' => 'links-input',
          'logo_url' => 'logo_url-input',
          'name' => 'name-input',
          'postal_code' => 'postal_code-input',
          'region' => 'region-input',
          'scheme_identifiers' => 'scheme_identifiers-input',
          'verification_status' => 'verification_status-input'
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/creditors})
          .with(
            body: {
              'creditors' => {

                'address_line1' => 'address_line1-input',
                'address_line2' => 'address_line2-input',
                'address_line3' => 'address_line3-input',
                'city' => 'city-input',
                'country_code' => 'country_code-input',
                'created_at' => 'created_at-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'logo_url' => 'logo_url-input',
                'name' => 'name-input',
                'postal_code' => 'postal_code-input',
                'region' => 'region-input',
                'scheme_identifiers' => 'scheme_identifiers-input',
                'verification_status' => 'verification_status-input'
              }
            }
          )
          .to_return(
            body: {
              'creditors' =>

                {

                  'address_line1' => 'address_line1-input',
                  'address_line2' => 'address_line2-input',
                  'address_line3' => 'address_line3-input',
                  'city' => 'city-input',
                  'country_code' => 'country_code-input',
                  'created_at' => 'created_at-input',
                  'id' => 'id-input',
                  'links' => 'links-input',
                  'logo_url' => 'logo_url-input',
                  'name' => 'name-input',
                  'postal_code' => 'postal_code-input',
                  'region' => 'region-input',
                  'scheme_identifiers' => 'scheme_identifiers-input',
                  'verification_status' => 'verification_status-input'
                }

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::Creditor)
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/creditors}).to_return(
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

          'address_line1' => 'address_line1-input',
          'address_line2' => 'address_line2-input',
          'address_line3' => 'address_line3-input',
          'city' => 'city-input',
          'country_code' => 'country_code-input',
          'created_at' => 'created_at-input',
          'id' => 'id-input',
          'links' => 'links-input',
          'logo_url' => 'logo_url-input',
          'name' => 'name-input',
          'postal_code' => 'postal_code-input',
          'region' => 'region-input',
          'scheme_identifiers' => 'scheme_identifiers-input',
          'verification_status' => 'verification_status-input'
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/creditors}).to_return(
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

      let!(:get_stub) do
        stub_url = "/creditors/#{id}"
        stub_request(:get, /.*api.gocardless.com#{stub_url}/)
          .to_return(
            body: {
              'creditors' => {

                'address_line1' => 'address_line1-input',
                'address_line2' => 'address_line2-input',
                'address_line3' => 'address_line3-input',
                'city' => 'city-input',
                'country_code' => 'country_code-input',
                'created_at' => 'created_at-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'logo_url' => 'logo_url-input',
                'name' => 'name-input',
                'postal_code' => 'postal_code-input',
                'region' => 'region-input',
                'scheme_identifiers' => 'scheme_identifiers-input',
                'verification_status' => 'verification_status-input'
              }
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

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.creditors.list }

      before do
        stub_request(:get, %r{.*api.gocardless.com/creditors}).to_return(
          body: {
            'creditors' => [{

              'address_line1' => 'address_line1-input',
              'address_line2' => 'address_line2-input',
              'address_line3' => 'address_line3-input',
              'city' => 'city-input',
              'country_code' => 'country_code-input',
              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'logo_url' => 'logo_url-input',
              'name' => 'name-input',
              'postal_code' => 'postal_code-input',
              'region' => 'region-input',
              'scheme_identifiers' => 'scheme_identifiers-input',
              'verification_status' => 'verification_status-input'
            }],
            meta: {
              cursors: {
                before: nil,
                after: 'ABC123'
              }
            }
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map(&:class).uniq.first).to eq(GoCardlessPro::Resources::Creditor)

        expect(get_list_response.records.first.address_line1).to eq('address_line1-input')

        expect(get_list_response.records.first.address_line2).to eq('address_line2-input')

        expect(get_list_response.records.first.address_line3).to eq('address_line3-input')

        expect(get_list_response.records.first.city).to eq('city-input')

        expect(get_list_response.records.first.country_code).to eq('country_code-input')

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.logo_url).to eq('logo_url-input')

        expect(get_list_response.records.first.name).to eq('name-input')

        expect(get_list_response.records.first.postal_code).to eq('postal_code-input')

        expect(get_list_response.records.first.region).to eq('region-input')

        expect(get_list_response.records.first.scheme_identifiers).to eq('scheme_identifiers-input')

        expect(get_list_response.records.first.verification_status).to eq('verification_status-input')
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
      stub_request(:get, %r{.*api.gocardless.com/creditors$}).to_return(
        body: {
          'creditors' => [{

            'address_line1' => 'address_line1-input',
            'address_line2' => 'address_line2-input',
            'address_line3' => 'address_line3-input',
            'city' => 'city-input',
            'country_code' => 'country_code-input',
            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'logo_url' => 'logo_url-input',
            'name' => 'name-input',
            'postal_code' => 'postal_code-input',
            'region' => 'region-input',
            'scheme_identifiers' => 'scheme_identifiers-input',
            'verification_status' => 'verification_status-input'
          }],
          meta: {
            cursors: { after: 'AB345' },
            limit: 1
          }
        }.to_json,
        headers: response_headers
      )
    end

    let!(:second_response_stub) do
      stub_request(:get, %r{.*api.gocardless.com/creditors\?after=AB345}).to_return(
        body: {
          'creditors' => [{

            'address_line1' => 'address_line1-input',
            'address_line2' => 'address_line2-input',
            'address_line3' => 'address_line3-input',
            'city' => 'city-input',
            'country_code' => 'country_code-input',
            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'logo_url' => 'logo_url-input',
            'name' => 'name-input',
            'postal_code' => 'postal_code-input',
            'region' => 'region-input',
            'scheme_identifiers' => 'scheme_identifiers-input',
            'verification_status' => 'verification_status-input'
          }],
          meta: {
            limit: 2,
            cursors: {}
          }
        }.to_json,
        headers: response_headers
      )
    end

    it 'automatically makes the extra requests' do
      expect(client.creditors.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.creditors.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/creditors/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/)
          .with(headers: { 'Foo' => 'Bar' })
          .to_return(
            body: {
              'creditors' => {

                'address_line1' => 'address_line1-input',
                'address_line2' => 'address_line2-input',
                'address_line3' => 'address_line3-input',
                'city' => 'city-input',
                'country_code' => 'country_code-input',
                'created_at' => 'created_at-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'logo_url' => 'logo_url-input',
                'name' => 'name-input',
                'postal_code' => 'postal_code-input',
                'region' => 'region-input',
                'scheme_identifiers' => 'scheme_identifiers-input',
                'verification_status' => 'verification_status-input'
              }
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.creditors.get(id, headers: {
                               'Foo' => 'Bar'
                             })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a creditor to return' do
      before do
        stub_url = '/creditors/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'creditors' => {

              'address_line1' => 'address_line1-input',
              'address_line2' => 'address_line2-input',
              'address_line3' => 'address_line3-input',
              'city' => 'city-input',
              'country_code' => 'country_code-input',
              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'logo_url' => 'logo_url-input',
              'name' => 'name-input',
              'postal_code' => 'postal_code-input',
              'region' => 'region-input',
              'scheme_identifiers' => 'scheme_identifiers-input',
              'verification_status' => 'verification_status-input'
            }
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::Creditor)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/creditors/:identity'.gsub(':identity', id)
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

  describe '#update' do
    subject(:put_update_response) { client.creditors.update(id, params: update_params) }
    let(:id) { 'ABC123' }

    context 'with a valid request' do
      let(:update_params) { { 'hello' => 'world' } }

      let!(:stub) do
        stub_url = '/creditors/:identity'.gsub(':identity', id)
        stub_request(:put, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'creditors' => {

              'address_line1' => 'address_line1-input',
              'address_line2' => 'address_line2-input',
              'address_line3' => 'address_line3-input',
              'city' => 'city-input',
              'country_code' => 'country_code-input',
              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'logo_url' => 'logo_url-input',
              'name' => 'name-input',
              'postal_code' => 'postal_code-input',
              'region' => 'region-input',
              'scheme_identifiers' => 'scheme_identifiers-input',
              'verification_status' => 'verification_status-input'
            }
          }.to_json,
          headers: response_headers
        )
      end

      it 'updates and returns the resource' do
        expect(put_update_response).to be_a(GoCardlessPro::Resources::Creditor)
        expect(stub).to have_been_requested
      end
    end
  end
end
