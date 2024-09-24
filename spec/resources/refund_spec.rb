require 'spec_helper'

describe GoCardlessPro::Resources::Refund do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.refunds.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'amount' => 'amount-input',
          'created_at' => 'created_at-input',
          'currency' => 'currency-input',
          'fx' => 'fx-input',
          'id' => 'id-input',
          'links' => 'links-input',
          'metadata' => 'metadata-input',
          'reference' => 'reference-input',
          'status' => 'status-input'
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/refunds})
          .with(
            body: {
              'refunds' => {

                'amount' => 'amount-input',
                'created_at' => 'created_at-input',
                'currency' => 'currency-input',
                'fx' => 'fx-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'reference' => 'reference-input',
                'status' => 'status-input'
              }
            }
          )
          .to_return(
            body: {
              'refunds' =>

                {

                  'amount' => 'amount-input',
                  'created_at' => 'created_at-input',
                  'currency' => 'currency-input',
                  'fx' => 'fx-input',
                  'id' => 'id-input',
                  'links' => 'links-input',
                  'metadata' => 'metadata-input',
                  'reference' => 'reference-input',
                  'status' => 'status-input'
                }

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::Refund)
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/refunds}).to_return(
          body: {
            error: {
              type: 'validation_failed',
              code: 422,
              errors: [
                { message: 'test error message', field: 'test_field' }
              ]
            }
          }.to_json,
          headers: response_headers,
          status: 422
        )
      end

      it 'throws the correct error' do
        expect { post_create_response }.to raise_error(GoCardlessPro::ValidationError)
      end
    end

    context 'with a request that returns an idempotent creation conflict error' do
      let(:id) { 'ID123' }

      let(:new_resource) do
        {

          'amount' => 'amount-input',
          'created_at' => 'created_at-input',
          'currency' => 'currency-input',
          'fx' => 'fx-input',
          'id' => 'id-input',
          'links' => 'links-input',
          'metadata' => 'metadata-input',
          'reference' => 'reference-input',
          'status' => 'status-input'
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/refunds}).to_return(
          body: {
            error: {
              type: 'invalid_state',
              code: 409,
              errors: [
                {
                  message: 'A resource has already been created with this idempotency key',
                  reason: 'idempotent_creation_conflict',
                  links: {
                    conflicting_resource_id: id
                  }
                }
              ]
            }
          }.to_json,
          headers: response_headers,
          status: 409
        )
      end

      let!(:get_stub) do
        stub_url = "/refunds/#{id}"
        stub_request(:get, /.*api.gocardless.com#{stub_url}/)
          .to_return(
            body: {
              'refunds' => {

                'amount' => 'amount-input',
                'created_at' => 'created_at-input',
                'currency' => 'currency-input',
                'fx' => 'fx-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'reference' => 'reference-input',
                'status' => 'status-input'
              }
            }.to_json,
            headers: response_headers
          )
      end

      it 'fetches the already-created resource' do
        post_create_response
        expect(post_stub).to have_been_requested
        expect(get_stub).to have_been_requested
      end
    end
  end

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.refunds.list }

      before do
        stub_request(:get, %r{.*api.gocardless.com/refunds}).to_return(
          body: {
            'refunds' => [{

              'amount' => 'amount-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'fx' => 'fx-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'reference' => 'reference-input',
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

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map { |x| x.class }.uniq.first).to eq(GoCardlessPro::Resources::Refund)

        expect(get_list_response.records.first.amount).to eq('amount-input')

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.currency).to eq('currency-input')

        expect(get_list_response.records.first.fx).to eq('fx-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.metadata).to eq('metadata-input')

        expect(get_list_response.records.first.reference).to eq('reference-input')

        expect(get_list_response.records.first.status).to eq('status-input')
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
      stub_request(:get, %r{.*api.gocardless.com/refunds$}).to_return(
        body: {
          'refunds' => [{

            'amount' => 'amount-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'fx' => 'fx-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'reference' => 'reference-input',
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
      stub_request(:get, %r{.*api.gocardless.com/refunds\?after=AB345}).to_return(
        body: {
          'refunds' => [{

            'amount' => 'amount-input',
            'created_at' => 'created_at-input',
            'currency' => 'currency-input',
            'fx' => 'fx-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'reference' => 'reference-input',
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
      expect(client.refunds.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.refunds.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/refunds/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/)
          .with(headers: { 'Foo' => 'Bar' })
          .to_return(
            body: {
              'refunds' => {

                'amount' => 'amount-input',
                'created_at' => 'created_at-input',
                'currency' => 'currency-input',
                'fx' => 'fx-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'reference' => 'reference-input',
                'status' => 'status-input'
              }
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.refunds.get(id, headers: {
                             'Foo' => 'Bar'
                           })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a refund to return' do
      before do
        stub_url = '/refunds/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'refunds' => {

              'amount' => 'amount-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'fx' => 'fx-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'reference' => 'reference-input',
              'status' => 'status-input'
            }
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::Refund)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/refunds/:identity'.gsub(':identity', id)
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

  describe '#update' do
    subject(:put_update_response) { client.refunds.update(id, params: update_params) }
    let(:id) { 'ABC123' }

    context 'with a valid request' do
      let(:update_params) { { 'hello' => 'world' } }

      let!(:stub) do
        stub_url = '/refunds/:identity'.gsub(':identity', id)
        stub_request(:put, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'refunds' => {

              'amount' => 'amount-input',
              'created_at' => 'created_at-input',
              'currency' => 'currency-input',
              'fx' => 'fx-input',
              'id' => 'id-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'reference' => 'reference-input',
              'status' => 'status-input'
            }
          }.to_json,
          headers: response_headers
        )
      end

      it 'updates and returns the resource' do
        expect(put_update_response).to be_a(GoCardlessPro::Resources::Refund)
        expect(stub).to have_been_requested
      end
    end
  end
end
