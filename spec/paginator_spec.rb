require 'spec_helper'

describe GoCardlessPro::Paginator do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe 'with URI parameters' do
    it 'passes URI parameters through to list method on initial request' do
      payment_account_id = 'BA123'

      first_response_stub = stub_request(:get, %r{.*api.gocardless.com/payment_accounts/#{payment_account_id}/transactions$}).to_return(
        body: {
          'payment_account_transactions' => [{
            'id' => 'PT001',
            'amount' => '100',
          }],
          meta: {
            cursors: {},
            limit: 1,
          },
        }.to_json,
        headers: response_headers
      )

      results = client.payment_account_transactions.all(payment_account_id).to_a

      expect(results.length).to eq(1)
      expect(first_response_stub).to have_been_requested
    end

    it 'passes URI parameters through to list method on paginated requests' do
      payment_account_id = 'BA123'

      first_response_stub = stub_request(:get, %r{.*api.gocardless.com/payment_accounts/#{payment_account_id}/transactions$}).to_return(
        body: {
          'payment_account_transactions' => [{
            'id' => 'PT001',
            'amount' => '100',
          }],
          meta: {
            cursors: { after: 'cursor123' },
            limit: 1,
          },
        }.to_json,
        headers: response_headers
      )

      second_response_stub = stub_request(:get, %r{.*api.gocardless.com/payment_accounts/#{payment_account_id}/transactions\?after=cursor123}).to_return(
        body: {
          'payment_account_transactions' => [{
            'id' => 'PT002',
            'amount' => '200',
          }],
          meta: {
            cursors: {},
            limit: 1,
          },
        }.to_json,
        headers: response_headers
      )

      results = client.payment_account_transactions.all(payment_account_id).to_a

      expect(results.length).to eq(2)
      expect(results[0].id).to eq('PT001')
      expect(results[1].id).to eq('PT002')
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    it 'handles query parameters alongside URI parameters' do
      payment_account_id = 'BA123'

      stub = stub_request(:get, %r{.*api.gocardless.com/payment_accounts/#{payment_account_id}/transactions\?.*limit=5}).to_return(
        body: {
          'payment_account_transactions' => [{
            'id' => 'PT001',
            'amount' => '100',
          }],
          meta: {
            cursors: {},
            limit: 1,
          },
        }.to_json,
        headers: response_headers
      )

      results = client.payment_account_transactions.all(payment_account_id, params: { limit: 5 }).to_a

      expect(results.length).to eq(1)
      expect(stub).to have_been_requested
    end
  end

  describe 'without URI parameters' do
    it 'works correctly for endpoints without URI parameters' do
      first_response_stub = stub_request(:get, %r{.*api.gocardless.com/payments$}).to_return(
        body: {
          'payments' => [{
            'id' => 'PM001',
            'amount' => '100',
          }],
          meta: {
            cursors: { after: 'cursor123' },
            limit: 1,
          },
        }.to_json,
        headers: response_headers
      )

      second_response_stub = stub_request(:get, %r{.*api.gocardless.com/payments\?after=cursor123}).to_return(
        body: {
          'payments' => [{
            'id' => 'PM002',
            'amount' => '200',
          }],
          meta: {
            cursors: {},
            limit: 1,
          },
        }.to_json,
        headers: response_headers
      )

      results = client.payments.all.to_a

      expect(results.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end
end
