require 'spec_helper'

describe GoCardlessPro::Services::InstitutionsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.institutions.list }

      let(:body) do
        {
          'institutions' => [{

            'autocompletes_collect_bank_account' => 'autocompletes_collect_bank_account-input',
            'country_code' => 'country_code-input',
            'icon_url' => 'icon_url-input',
            'id' => 'id-input',
            'limits' => 'limits-input',
            'logo_url' => 'logo_url-input',
            'name' => 'name-input',
            'status' => 'status-input'
          }],
          meta: {
            cursors: {
              before: nil,
              after: 'ABC123'
            }
          }
        }.to_json
      end

      before do
        stub_request(:get, %r{.*api.gocardless.com/institutions}).to_return(
          body: body,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map { |x| x.class }.uniq.first).to eq(GoCardlessPro::Resources::Institution)

        expect(get_list_response.records.first.autocompletes_collect_bank_account).to eq('autocompletes_collect_bank_account-input')

        expect(get_list_response.records.first.country_code).to eq('country_code-input')

        expect(get_list_response.records.first.icon_url).to eq('icon_url-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.limits).to eq('limits-input')

        expect(get_list_response.records.first.logo_url).to eq('logo_url-input')

        expect(get_list_response.records.first.name).to eq('name-input')

        expect(get_list_response.records.first.status).to eq('status-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:get, %r{.*api.gocardless.com/institutions})
                 .to_timeout.then.to_return({ status: 200, headers: response_headers, body: body })

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/institutions})
                 .to_return({ status: 502,
                              headers: { 'Content-Type' => 'text/html' },
                              body: '<html><body>Response from Cloudflare</body></html>' })
                 .then.to_return({ status: 200, headers: response_headers, body: body })

          get_list_response
          expect(stub).to have_been_requested.twice
        end
      end
    end
  end

  describe '#all' do
    let!(:first_response_stub) do
      stub_request(:get, %r{.*api.gocardless.com/institutions$}).to_return(
        body: {
          'institutions' => [{

            'autocompletes_collect_bank_account' => 'autocompletes_collect_bank_account-input',
            'country_code' => 'country_code-input',
            'icon_url' => 'icon_url-input',
            'id' => 'id-input',
            'limits' => 'limits-input',
            'logo_url' => 'logo_url-input',
            'name' => 'name-input',
            'status' => 'status-input'
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
      stub_request(:get, %r{.*api.gocardless.com/institutions\?after=AB345}).to_return(
        body: {
          'institutions' => [{

            'autocompletes_collect_bank_account' => 'autocompletes_collect_bank_account-input',
            'country_code' => 'country_code-input',
            'icon_url' => 'icon_url-input',
            'id' => 'id-input',
            'limits' => 'limits-input',
            'logo_url' => 'logo_url-input',
            'name' => 'name-input',
            'status' => 'status-input'
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
      expect(client.institutions.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/institutions$}).to_return(
          body: {
            'institutions' => [{

              'autocompletes_collect_bank_account' => 'autocompletes_collect_bank_account-input',
              'country_code' => 'country_code-input',
              'icon_url' => 'icon_url-input',
              'id' => 'id-input',
              'limits' => 'limits-input',
              'logo_url' => 'logo_url-input',
              'name' => 'name-input',
              'status' => 'status-input'
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1
            }
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/institutions\?after=AB345})
                               .to_timeout.then
                               .to_return(
                                 body: {
                                   'institutions' => [{

                                     'autocompletes_collect_bank_account' => 'autocompletes_collect_bank_account-input',
                                     'country_code' => 'country_code-input',
                                     'icon_url' => 'icon_url-input',
                                     'id' => 'id-input',
                                     'limits' => 'limits-input',
                                     'logo_url' => 'logo_url-input',
                                     'name' => 'name-input',
                                     'status' => 'status-input'
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {}
                                   }
                                 }.to_json,
                                 headers: response_headers
                               )

        client.institutions.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/institutions$}).to_return(
          body: {
            'institutions' => [{

              'autocompletes_collect_bank_account' => 'autocompletes_collect_bank_account-input',
              'country_code' => 'country_code-input',
              'icon_url' => 'icon_url-input',
              'id' => 'id-input',
              'limits' => 'limits-input',
              'logo_url' => 'logo_url-input',
              'name' => 'name-input',
              'status' => 'status-input'
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1
            }
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/institutions\?after=AB345})
                               .to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
                                 body: {
                                   'institutions' => [{

                                     'autocompletes_collect_bank_account' => 'autocompletes_collect_bank_account-input',
                                     'country_code' => 'country_code-input',
                                     'icon_url' => 'icon_url-input',
                                     'id' => 'id-input',
                                     'limits' => 'limits-input',
                                     'logo_url' => 'logo_url-input',
                                     'name' => 'name-input',
                                     'status' => 'status-input'
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {}
                                   }
                                 }.to_json,
                                 headers: response_headers
                               )

        client.institutions.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
    end
  end

  describe '#list_for_billing_request' do
    subject(:get_response) { client.institutions.list_for_billing_request(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /billing_requests/%v/institutions
      stub_url = '/billing_requests/:identity/institutions'.gsub(':identity', resource_id)
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'institutions' => [{

            'autocompletes_collect_bank_account' => 'autocompletes_collect_bank_account-input',
            'country_code' => 'country_code-input',
            'icon_url' => 'icon_url-input',
            'id' => 'id-input',
            'limits' => 'limits-input',
            'logo_url' => 'logo_url-input',
            'name' => 'name-input',
            'status' => 'status-input'
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

    it 'wraps the response and calls the right endpoint' do
      expect(get_response.records.map { |x| x.class }.uniq.first).to eq(GoCardlessPro::Resources::Institution)

      expect(stub).to have_been_requested
    end

    it 'exposes the cursors for before and after' do
      expect(get_response.before).to eq(nil)
      expect(get_response.after).to eq('ABC123')
    end

    describe 'retry behaviour' do
      it "doesn't retry errors" do
        stub_url = '/billing_requests/:identity/institutions'.gsub(':identity', resource_id)
        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/)
               .to_timeout

        expect { get_response }.to raise_error(Faraday::ConnectionFailed)
        expect(stub).to have_been_requested
      end
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:get_response) { client.institutions.list_for_billing_request(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /billing_requests/%v/institutions
        stub_url = '/billing_requests/:identity/institutions'.gsub(':identity', resource_id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/)
          .with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'institutions' => {

                'autocompletes_collect_bank_account' => 'autocompletes_collect_bank_account-input',
                'country_code' => 'country_code-input',
                'icon_url' => 'icon_url-input',
                'id' => 'id-input',
                'limits' => 'limits-input',
                'logo_url' => 'logo_url-input',
                'name' => 'name-input',
                'status' => 'status-input'
              }
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
