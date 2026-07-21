require 'spec_helper'

describe GoCardlessPro::Resources::OutboundPaymentImportEntry do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.outbound_payment_import_entries.list }

      before do
        stub_request(:get, %r{.*api.gocardless.com/outbound_payment_import_entries}).to_return(
          body: {
            'outbound_payment_import_entries' => [{

              'amount' => 'amount-input',
              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'processed_at' => 'processed_at-input',
              'reference' => 'reference-input',
              'scheme' => 'scheme-input',
              'validation_errors' => 'validation_errors-input',
              'verification_result' => 'verification_result-input',
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
        expect(get_list_response.records.map { |x| x.class }.uniq.first).to eq(GoCardlessPro::Resources::OutboundPaymentImportEntry)

        expect(get_list_response.records.first.amount).to eq('amount-input')

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.metadata).to eq('metadata-input')

        expect(get_list_response.records.first.processed_at).to eq('processed_at-input')

        expect(get_list_response.records.first.reference).to eq('reference-input')

        expect(get_list_response.records.first.scheme).to eq('scheme-input')

        expect(get_list_response.records.first.validation_errors).to eq('validation_errors-input')

        expect(get_list_response.records.first.verification_result).to eq('verification_result-input')
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
      stub_request(:get, %r{.*api.gocardless.com/outbound_payment_import_entries$}).to_return(
        body: {
          'outbound_payment_import_entries' => [{

            'amount' => 'amount-input',
            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'processed_at' => 'processed_at-input',
            'reference' => 'reference-input',
            'scheme' => 'scheme-input',
            'validation_errors' => 'validation_errors-input',
            'verification_result' => 'verification_result-input',
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
      stub_request(:get, %r{.*api.gocardless.com/outbound_payment_import_entries\?after=AB345}).to_return(
        body: {
          'outbound_payment_import_entries' => [{

            'amount' => 'amount-input',
            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'processed_at' => 'processed_at-input',
            'reference' => 'reference-input',
            'scheme' => 'scheme-input',
            'validation_errors' => 'validation_errors-input',
            'verification_result' => 'verification_result-input',
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
      expect(client.outbound_payment_import_entries.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end
end
