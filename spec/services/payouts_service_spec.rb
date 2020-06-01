require 'spec_helper'

describe GoCardlessPro::Services::PayoutsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.payouts.list }

      let(:body) do
        {
          'payouts' => [{

            'amount' => 'amount-input',
            'arrival_date' => 'arrival_date-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'deducted_fees' => 'deducted_fees-input',
            'fx' => 'fx-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'payout_type' => 'payout_type-input',
            'reference' => 'reference-input',
            'status' => 'status-input',
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
        stub_request(:get, %r{.*api.gocardless.com/payouts}).to_return(
          body: body,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map(&:class).uniq.first).to eq(GoCardlessPro::Resources::Payout)

        expect(get_list_response.records.first.amount).to eq('amount-input')

        expect(get_list_response.records.first.arrival_date).to eq('arrival_date-input')

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.currency).to eq('currency-input')

        expect(get_list_response.records.first.deducted_fees).to eq('deducted_fees-input')

        expect(get_list_response.records.first.fx).to eq('fx-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.metadata).to eq('metadata-input')

        expect(get_list_response.records.first.payout_type).to eq('payout_type-input')

        expect(get_list_response.records.first.reference).to eq('reference-input')

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
          stub = stub_request(:get, %r{.*api.gocardless.com/payouts}).
                 to_timeout.then.to_return(status: 200, headers: response_headers, body: body)

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/payouts}).
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
      stub_request(:get, %r{.*api.gocardless.com/payouts$}).to_return(
        body: {
          'payouts' => [{

            'amount' => 'amount-input',
            'arrival_date' => 'arrival_date-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'deducted_fees' => 'deducted_fees-input',
            'fx' => 'fx-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'payout_type' => 'payout_type-input',
            'reference' => 'reference-input',
            'status' => 'status-input',
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
      stub_request(:get, %r{.*api.gocardless.com/payouts\?after=AB345}).to_return(
        body: {
          'payouts' => [{

            'amount' => 'amount-input',
            'arrival_date' => 'arrival_date-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'deducted_fees' => 'deducted_fees-input',
            'fx' => 'fx-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'payout_type' => 'payout_type-input',
            'reference' => 'reference-input',
            'status' => 'status-input',
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
      expect(client.payouts.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/payouts$}).to_return(
          body: {
            'payouts' => [{

              'amount' => 'amount-input',
              'arrival_date' => 'arrival_date-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'deducted_fees' => 'deducted_fees-input',
              'fx' => 'fx-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'payout_type' => 'payout_type-input',
              'reference' => 'reference-input',
              'status' => 'status-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/payouts\?after=AB345}).
                               to_timeout.then.
                               to_return(
                                 body: {
                                   'payouts' => [{

                                     'amount' => 'amount-input',
                                     'arrival_date' => 'arrival_date-input',
                                     'created_at' => 'created_at-input',
                                     'currency' => 'currency-input',
                                     'deducted_fees' => 'deducted_fees-input',
                                     'fx' => 'fx-input',
                                     'id' => 'id-input',
                                     'links' => 'links-input',
                                     'metadata' => 'metadata-input',
                                     'payout_type' => 'payout_type-input',
                                     'reference' => 'reference-input',
                                     'status' => 'status-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.payouts.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/payouts$}).to_return(
          body: {
            'payouts' => [{

              'amount' => 'amount-input',
              'arrival_date' => 'arrival_date-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'deducted_fees' => 'deducted_fees-input',
              'fx' => 'fx-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'payout_type' => 'payout_type-input',
              'reference' => 'reference-input',
              'status' => 'status-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/payouts\?after=AB345}).
                               to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
                                 body: {
                                   'payouts' => [{

                                     'amount' => 'amount-input',
                                     'arrival_date' => 'arrival_date-input',
                                     'created_at' => 'created_at-input',
                                     'currency' => 'currency-input',
                                     'deducted_fees' => 'deducted_fees-input',
                                     'fx' => 'fx-input',
                                     'id' => 'id-input',
                                     'links' => 'links-input',
                                     'metadata' => 'metadata-input',
                                     'payout_type' => 'payout_type-input',
                                     'reference' => 'reference-input',
                                     'status' => 'status-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.payouts.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
    end
  end

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.payouts.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/payouts/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              'payouts' => {

                'amount' => 'amount-input',
                'arrival_date' => 'arrival_date-input',
                'created_at' => 'created_at-input',
                'currency' => 'currency-input',
                'deducted_fees' => 'deducted_fees-input',
                'fx' => 'fx-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'payout_type' => 'payout_type-input',
                'reference' => 'reference-input',
                'status' => 'status-input',
              },
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.payouts.get(id, headers: {
                             'Foo' => 'Bar',
                           })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a payout to return' do
      before do
        stub_url = '/payouts/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'payouts' => {

              'amount' => 'amount-input',
              'arrival_date' => 'arrival_date-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'deducted_fees' => 'deducted_fees-input',
              'fx' => 'fx-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'payout_type' => 'payout_type-input',
              'reference' => 'reference-input',
              'status' => 'status-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::Payout)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/payouts/:identity'.gsub(':identity', id)
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
        stub_url = '/payouts/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_timeout.then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 5XX errors, other than 500s' do
        stub_url = '/payouts/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_return(status: 502,
                         headers: { 'Content-Type' => 'text/html' },
                         body: '<html><body>Response from Cloudflare</body></html>').
               then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 500 errors returned by the API' do
        stub_url = '/payouts/:identity'.gsub(':identity', id)

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
    subject(:put_update_response) { client.payouts.update(id, params: update_params) }
    let(:id) { 'ABC123' }

    context 'with a valid request' do
      let(:update_params) { { 'hello' => 'world' } }

      let!(:stub) do
        stub_url = '/payouts/:identity'.gsub(':identity', id)
        stub_request(:put, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'payouts' => {

              'amount' => 'amount-input',
              'arrival_date' => 'arrival_date-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'deducted_fees' => 'deducted_fees-input',
              'fx' => 'fx-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'payout_type' => 'payout_type-input',
              'reference' => 'reference-input',
              'status' => 'status-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'updates and returns the resource' do
        expect(put_update_response).to be_a(GoCardlessPro::Resources::Payout)
        expect(stub).to have_been_requested
      end

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub_url = '/payouts/:identity'.gsub(':identity', id)
          stub = stub_request(:put, /.*api.gocardless.com#{stub_url}/).
                 to_timeout.then.to_return(status: 200, headers: response_headers)

          put_update_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub_url = '/payouts/:identity'.gsub(':identity', id)
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
end
