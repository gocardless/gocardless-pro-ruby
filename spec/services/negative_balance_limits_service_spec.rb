require 'spec_helper'

describe GoCardlessPro::Services::NegativeBalanceLimitsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.negative_balance_limits.list }

      let(:body) do
        {
          'negative_balance_limits' => [{

            'balance_limit' => 'balance_limit-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'id' => 'id-input',
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
        stub_request(:get, %r{.*api.gocardless.com/negative_balance_limits}).to_return(
          body: body,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map do |x|
                 x.class
               end.uniq.first).to eq(GoCardlessPro::Resources::NegativeBalanceLimit)

        expect(get_list_response.records.first.balance_limit).to eq('balance_limit-input')

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.currency).to eq('currency-input')

        expect(get_list_response.records.first.id).to eq('id-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:get, %r{.*api.gocardless.com/negative_balance_limits})
                 .to_timeout.then.to_return({ status: 200, headers: response_headers, body: body })

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/negative_balance_limits})
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
      stub_request(:get, %r{.*api.gocardless.com/negative_balance_limits$}).to_return(
        body: {
          'negative_balance_limits' => [{

            'balance_limit' => 'balance_limit-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'id' => 'id-input',
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
      stub_request(:get, %r{.*api.gocardless.com/negative_balance_limits\?after=AB345}).to_return(
        body: {
          'negative_balance_limits' => [{

            'balance_limit' => 'balance_limit-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'id' => 'id-input',
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
      expect(client.negative_balance_limits.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/negative_balance_limits$}).to_return(
          body: {
            'negative_balance_limits' => [{

              'balance_limit' => 'balance_limit-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'id' => 'id-input',
              'links' => 'links-input'
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1
            }
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/negative_balance_limits\?after=AB345})
                               .to_timeout.then
                               .to_return(
                                 body: {
                                   'negative_balance_limits' => [{

                                     'balance_limit' => 'balance_limit-input',
                                     'created_at' => 'created_at-input',
                                     'currency' => 'currency-input',
                                     'id' => 'id-input',
                                     'links' => 'links-input'
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {}
                                   }
                                 }.to_json,
                                 headers: response_headers
                               )

        client.negative_balance_limits.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/negative_balance_limits$}).to_return(
          body: {
            'negative_balance_limits' => [{

              'balance_limit' => 'balance_limit-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'id' => 'id-input',
              'links' => 'links-input'
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1
            }
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/negative_balance_limits\?after=AB345})
                               .to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
                                 body: {
                                   'negative_balance_limits' => [{

                                     'balance_limit' => 'balance_limit-input',
                                     'created_at' => 'created_at-input',
                                     'currency' => 'currency-input',
                                     'id' => 'id-input',
                                     'links' => 'links-input'
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {}
                                   }
                                 }.to_json,
                                 headers: response_headers
                               )

        client.negative_balance_limits.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
    end
  end
end
