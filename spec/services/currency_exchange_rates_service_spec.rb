require 'spec_helper'

describe GoCardlessPro::Services::CurrencyExchangeRatesService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.currency_exchange_rates.list }

      let(:body) do
        {
          'currency_exchange_rates' => [{

            'rate' => 'rate-input',
            'source' => 'source-input',
            'target' => 'target-input',
            'time' => 'time-input',
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
        stub_request(:get, %r{.*api.gocardless.com/currency_exchange_rates}).to_return(
          body: body,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map do |x|
                 x.class
               end.uniq.first).to eq(GoCardlessPro::Resources::CurrencyExchangeRate)

        expect(get_list_response.records.first.rate).to eq('rate-input')

        expect(get_list_response.records.first.source).to eq('source-input')

        expect(get_list_response.records.first.target).to eq('target-input')

        expect(get_list_response.records.first.time).to eq('time-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:get, %r{.*api.gocardless.com/currency_exchange_rates}).
                 to_timeout.then.to_return({ status: 200, headers: response_headers, body: body })

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/currency_exchange_rates}).
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
      stub_request(:get, %r{.*api.gocardless.com/currency_exchange_rates$}).to_return(
        body: {
          'currency_exchange_rates' => [{

            'rate' => 'rate-input',
            'source' => 'source-input',
            'target' => 'target-input',
            'time' => 'time-input',
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
      stub_request(:get, %r{.*api.gocardless.com/currency_exchange_rates\?after=AB345}).to_return(
        body: {
          'currency_exchange_rates' => [{

            'rate' => 'rate-input',
            'source' => 'source-input',
            'target' => 'target-input',
            'time' => 'time-input',
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
      expect(client.currency_exchange_rates.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/currency_exchange_rates$}).to_return(
          body: {
            'currency_exchange_rates' => [{

              'rate' => 'rate-input',
              'source' => 'source-input',
              'target' => 'target-input',
              'time' => 'time-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/currency_exchange_rates\?after=AB345}).
                               to_timeout.then.
                               to_return(
                                 body: {
                                   'currency_exchange_rates' => [{

                                     'rate' => 'rate-input',
                                     'source' => 'source-input',
                                     'target' => 'target-input',
                                     'time' => 'time-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.currency_exchange_rates.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/currency_exchange_rates$}).to_return(
          body: {
            'currency_exchange_rates' => [{

              'rate' => 'rate-input',
              'source' => 'source-input',
              'target' => 'target-input',
              'time' => 'time-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/currency_exchange_rates\?after=AB345}).
                               to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
                                 body: {
                                   'currency_exchange_rates' => [{

                                     'rate' => 'rate-input',
                                     'source' => 'source-input',
                                     'target' => 'target-input',
                                     'time' => 'time-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.currency_exchange_rates.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
    end
  end
end
