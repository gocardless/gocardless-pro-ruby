require 'spec_helper'

describe GoCardlessPro::Services::BalancesService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.balances.list }

      let(:body) do
        {
          'balances' => [{

            'amount' => 'amount-input',
            'balance_type' => 'balance_type-input',
            'currency' => 'currency-input',
            'last_updated_at' => 'last_updated_at-input',
            'links' => 'links-input'
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
        stub_request(:get, %r{.*api.gocardless.com/balances}).to_return(
          body: body,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map { |x| x.class }.uniq.first).to eq(GoCardlessPro::Resources::Balance)

        expect(get_list_response.records.first.amount).to eq('amount-input')

        expect(get_list_response.records.first.balance_type).to eq('balance_type-input')

        expect(get_list_response.records.first.currency).to eq('currency-input')

        expect(get_list_response.records.first.last_updated_at).to eq('last_updated_at-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:get, %r{.*api.gocardless.com/balances})
                 .to_timeout.then.to_return({ status: 200, headers: response_headers, body: body })

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/balances})
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
      stub_request(:get, %r{.*api.gocardless.com/balances$}).to_return(
        body: {
          'balances' => [{

            'amount' => 'amount-input',
            'balance_type' => 'balance_type-input',
            'currency' => 'currency-input',
            'last_updated_at' => 'last_updated_at-input',
            'links' => 'links-input'
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
      stub_request(:get, %r{.*api.gocardless.com/balances\?after=AB345}).to_return(
        body: {
          'balances' => [{

            'amount' => 'amount-input',
            'balance_type' => 'balance_type-input',
            'currency' => 'currency-input',
            'last_updated_at' => 'last_updated_at-input',
            'links' => 'links-input'
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
      expect(client.balances.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/balances$}).to_return(
          body: {
            'balances' => [{

              'amount' => 'amount-input',
              'balance_type' => 'balance_type-input',
              'currency' => 'currency-input',
              'last_updated_at' => 'last_updated_at-input',
              'links' => 'links-input'
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1
            }
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/balances\?after=AB345})
                               .to_timeout.then
                               .to_return(
                                 body: {
                                   'balances' => [{

                                     'amount' => 'amount-input',
                                     'balance_type' => 'balance_type-input',
                                     'currency' => 'currency-input',
                                     'last_updated_at' => 'last_updated_at-input',
                                     'links' => 'links-input'
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {}
                                   }
                                 }.to_json,
                                 headers: response_headers
                               )

        client.balances.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/balances$}).to_return(
          body: {
            'balances' => [{

              'amount' => 'amount-input',
              'balance_type' => 'balance_type-input',
              'currency' => 'currency-input',
              'last_updated_at' => 'last_updated_at-input',
              'links' => 'links-input'
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1
            }
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/balances\?after=AB345})
                               .to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
                                 body: {
                                   'balances' => [{

                                     'amount' => 'amount-input',
                                     'balance_type' => 'balance_type-input',
                                     'currency' => 'currency-input',
                                     'last_updated_at' => 'last_updated_at-input',
                                     'links' => 'links-input'
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {}
                                   }
                                 }.to_json,
                                 headers: response_headers
                               )

        client.balances.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
    end
  end
end
