require 'spec_helper'

describe GoCardlessPro::Resources::TaxRate do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.tax_rates.list }

      before do
        stub_request(:get, %r{.*api.gocardless.com/tax_rates}).to_return(
          body: {
            'tax_rates' => [{

              'end_date' => 'end_date-input',
              'id' => 'id-input',
              'jurisdiction' => 'jurisdiction-input',
              'percentage' => 'percentage-input',
              'start_date' => 'start_date-input',
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
        expect(get_list_response.records.map { |x| x.class }.uniq.first).to eq(GoCardlessPro::Resources::TaxRate)

        expect(get_list_response.records.first.end_date).to eq('end_date-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.jurisdiction).to eq('jurisdiction-input')

        expect(get_list_response.records.first.percentage).to eq('percentage-input')

        expect(get_list_response.records.first.start_date).to eq('start_date-input')

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
      stub_request(:get, %r{.*api.gocardless.com/tax_rates$}).to_return(
        body: {
          'tax_rates' => [{

            'end_date' => 'end_date-input',
            'id' => 'id-input',
            'jurisdiction' => 'jurisdiction-input',
            'percentage' => 'percentage-input',
            'start_date' => 'start_date-input',
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
      stub_request(:get, %r{.*api.gocardless.com/tax_rates\?after=AB345}).to_return(
        body: {
          'tax_rates' => [{

            'end_date' => 'end_date-input',
            'id' => 'id-input',
            'jurisdiction' => 'jurisdiction-input',
            'percentage' => 'percentage-input',
            'start_date' => 'start_date-input',
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
      expect(client.tax_rates.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.tax_rates.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/tax_rates/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              'tax_rates' => {

                'end_date' => 'end_date-input',
                'id' => 'id-input',
                'jurisdiction' => 'jurisdiction-input',
                'percentage' => 'percentage-input',
                'start_date' => 'start_date-input',
                'type' => 'type-input',
              },
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.tax_rates.get(id, headers: {
                               'Foo' => 'Bar',
                             })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a tax_rate to return' do
      before do
        stub_url = '/tax_rates/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'tax_rates' => {

              'end_date' => 'end_date-input',
              'id' => 'id-input',
              'jurisdiction' => 'jurisdiction-input',
              'percentage' => 'percentage-input',
              'start_date' => 'start_date-input',
              'type' => 'type-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::TaxRate)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/tax_rates/:identity'.gsub(':identity', id)
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
  end
end
