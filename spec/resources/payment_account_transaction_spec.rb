require 'spec_helper'

describe GoCardlessPro::Resources::PaymentAccountTransaction do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      let(:identity) { 'ID123' }

      subject(:get_list_response) { client.payment_account_transactions.list(identity) }

      before do
        stub_url = '/payment_accounts/:identity/transactions'.gsub(':identity', identity)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'payment_account_transactions' => [{

              'amount' => 'amount-input',
              'balance_after_transaction' => 'balance_after_transaction-input',
              'counterparty_name' => 'counterparty_name-input',
              'currency' => 'currency-input',
              'description' => 'description-input',
              'direction' => 'direction-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'reference' => 'reference-input',
              'value_date' => 'value_date-input',
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
        expect(get_list_response.records.map do |x|
                 x.class
               end.uniq.first).to eq(GoCardlessPro::Resources::PaymentAccountTransaction)

        expect(get_list_response.records.first.amount).to eq('amount-input')

        expect(get_list_response.records.first.balance_after_transaction).to eq('balance_after_transaction-input')

        expect(get_list_response.records.first.counterparty_name).to eq('counterparty_name-input')

        expect(get_list_response.records.first.currency).to eq('currency-input')

        expect(get_list_response.records.first.description).to eq('description-input')

        expect(get_list_response.records.first.direction).to eq('direction-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.reference).to eq('reference-input')

        expect(get_list_response.records.first.value_date).to eq('value_date-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }
    end
  end

  describe '#all' do
    let(:identity) { 'ID123' }

    let!(:first_response_stub) do
      stub_url = '/payment_accounts/:identity/transactions'.gsub(':identity', identity)
      stub_request(:get, /.*api.gocardless.com#{stub_url}$/).to_return(
        body: {
          'payment_account_transactions' => [{

            'amount' => 'amount-input',
            'balance_after_transaction' => 'balance_after_transaction-input',
            'counterparty_name' => 'counterparty_name-input',
            'currency' => 'currency-input',
            'description' => 'description-input',
            'direction' => 'direction-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'reference' => 'reference-input',
            'value_date' => 'value_date-input',
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
      stub_url = '/payment_accounts/:identity/transactions'.gsub(':identity', identity)
      stub_request(:get, /.*api.gocardless.com#{stub_url}\?after=AB345/).to_return(
        body: {
          'payment_account_transactions' => [{

            'amount' => 'amount-input',
            'balance_after_transaction' => 'balance_after_transaction-input',
            'counterparty_name' => 'counterparty_name-input',
            'currency' => 'currency-input',
            'description' => 'description-input',
            'direction' => 'direction-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'reference' => 'reference-input',
            'value_date' => 'value_date-input',
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
      expect(client.payment_account_transactions.all(identity).to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end
end
