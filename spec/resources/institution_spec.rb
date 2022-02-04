require 'spec_helper'

describe GoCardlessPro::Resources::Institution do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.institutions.list }

      before do
        stub_request(:get, %r{.*api.gocardless.com/institutions}).to_return(
          body: {
            'institutions' => [{

              'country_code' => 'country_code-input',
              'icon_url' => 'icon_url-input',
              'id' => 'id-input',
              'logo_url' => 'logo_url-input',
              'name' => 'name-input',
              'roles' => 'roles-input',
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
        expect(get_list_response.records.map(&:class).uniq.first).to eq(GoCardlessPro::Resources::Institution)

        expect(get_list_response.records.first.country_code).to eq('country_code-input')

        expect(get_list_response.records.first.icon_url).to eq('icon_url-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.logo_url).to eq('logo_url-input')

        expect(get_list_response.records.first.name).to eq('name-input')

        expect(get_list_response.records.first.roles).to eq('roles-input')
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
      stub_request(:get, %r{.*api.gocardless.com/institutions$}).to_return(
        body: {
          'institutions' => [{

            'country_code' => 'country_code-input',
            'icon_url' => 'icon_url-input',
            'id' => 'id-input',
            'logo_url' => 'logo_url-input',
            'name' => 'name-input',
            'roles' => 'roles-input',
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
      stub_request(:get, %r{.*api.gocardless.com/institutions\?after=AB345}).to_return(
        body: {
          'institutions' => [{

            'country_code' => 'country_code-input',
            'icon_url' => 'icon_url-input',
            'id' => 'id-input',
            'logo_url' => 'logo_url-input',
            'name' => 'name-input',
            'roles' => 'roles-input',
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
      expect(client.institutions.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end
end
