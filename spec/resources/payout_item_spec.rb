require 'spec_helper'

describe GoCardlessPro::Resources::PayoutItem do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.payout_items.list }

      before do
        stub_request(:get, %r{.*api.gocardless.com/payout_items}).to_return(
          body: {
            'payout_items' => [{

              'amount' => 'amount-input',
              'links' => 'links-input',
              'taxes' => 'taxes-input',
              'type' => 'type-input',
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
        expect(get_list_response.records.map(&:class).uniq.first).to eq(GoCardlessPro::Resources::PayoutItem)

        expect(get_list_response.records.first.amount).to eq('amount-input')

        expect(get_list_response.records.first.taxes).to eq('taxes-input')

        expect(get_list_response.records.first.type).to eq('type-input')
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
      stub_request(:get, %r{.*api.gocardless.com/payout_items$}).to_return(
        body: {
          'payout_items' => [{

            'amount' => 'amount-input',
            'links' => 'links-input',
            'taxes' => 'taxes-input',
            'type' => 'type-input',
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
      stub_request(:get, %r{.*api.gocardless.com/payout_items\?after=AB345}).to_return(
        body: {
          'payout_items' => [{

            'amount' => 'amount-input',
            'links' => 'links-input',
            'taxes' => 'taxes-input',
            'type' => 'type-input',
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
      expect(client.payout_items.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end
end
