require 'spec_helper'

describe GoCardlessPro::Resources::OutboundPayment do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.outbound_payments.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'amount' => 'amount-input',
          'created_at' => 'created_at-input',
          'description' => 'description-input',
          'execution_date' => 'execution_date-input',
          'id' => 'id-input',
          'is_withdrawal' => 'is_withdrawal-input',
          'links' => 'links-input',
          'metadata' => 'metadata-input',
          'reference' => 'reference-input',
          'scheme' => 'scheme-input',
          'status' => 'status-input',
          'verifications' => 'verifications-input'
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/outbound_payments})
          .with(
            body: {
              'outbound_payments' => {

                'amount' => 'amount-input',
                'created_at' => 'created_at-input',
                'description' => 'description-input',
                'execution_date' => 'execution_date-input',
                'id' => 'id-input',
                'is_withdrawal' => 'is_withdrawal-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'reference' => 'reference-input',
                'scheme' => 'scheme-input',
                'status' => 'status-input',
                'verifications' => 'verifications-input'
              }
            }
          )
          .to_return(
            body: {
              'outbound_payments' =>

                {

                  'amount' => 'amount-input',
                  'created_at' => 'created_at-input',
                  'description' => 'description-input',
                  'execution_date' => 'execution_date-input',
                  'id' => 'id-input',
                  'is_withdrawal' => 'is_withdrawal-input',
                  'links' => 'links-input',
                  'metadata' => 'metadata-input',
                  'reference' => 'reference-input',
                  'scheme' => 'scheme-input',
                  'status' => 'status-input',
                  'verifications' => 'verifications-input'
                }

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::OutboundPayment)
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/outbound_payments}).to_return(
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
          'description' => 'description-input',
          'execution_date' => 'execution_date-input',
          'id' => 'id-input',
          'is_withdrawal' => 'is_withdrawal-input',
          'links' => 'links-input',
          'metadata' => 'metadata-input',
          'reference' => 'reference-input',
          'scheme' => 'scheme-input',
          'status' => 'status-input',
          'verifications' => 'verifications-input'
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/outbound_payments}).to_return(
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
        stub_url = "/outbound_payments/#{id}"
        stub_request(:get, /.*api.gocardless.com#{stub_url}/)
          .to_return(
            body: {
              'outbound_payments' => {

                'amount' => 'amount-input',
                'created_at' => 'created_at-input',
                'description' => 'description-input',
                'execution_date' => 'execution_date-input',
                'id' => 'id-input',
                'is_withdrawal' => 'is_withdrawal-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'reference' => 'reference-input',
                'scheme' => 'scheme-input',
                'status' => 'status-input',
                'verifications' => 'verifications-input'
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

  describe '#withdraw' do
    subject(:post_response) { client.outbound_payments.withdraw }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /outbound_payments/withdrawal
      stub_url = '/outbound_payments/withdrawal'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'outbound_payments' => {

            'amount' => 'amount-input',
            'created_at' => 'created_at-input',
            'description' => 'description-input',
            'execution_date' => 'execution_date-input',
            'id' => 'id-input',
            'is_withdrawal' => 'is_withdrawal-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'reference' => 'reference-input',
            'scheme' => 'scheme-input',
            'status' => 'status-input',
            'verifications' => 'verifications-input'
          }
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::OutboundPayment)

      expect(stub).to have_been_requested
    end

    context 'when the request needs a body and custom header' do
      subject(:post_response) { client.outbound_payments.withdraw(body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /outbound_payments/withdrawal
        stub_url = '/outbound_payments/withdrawal'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/)
          .with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'outbound_payments' => {

                'amount' => 'amount-input',
                'created_at' => 'created_at-input',
                'description' => 'description-input',
                'execution_date' => 'execution_date-input',
                'id' => 'id-input',
                'is_withdrawal' => 'is_withdrawal-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'reference' => 'reference-input',
                'scheme' => 'scheme-input',
                'status' => 'status-input',
                'verifications' => 'verifications-input'
              }
            }.to_json,
            headers: response_headers
          )
      end
    end
  end

  describe '#cancel' do
    subject(:post_response) { client.outbound_payments.cancel(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /outbound_payments/%v/actions/cancel
      stub_url = '/outbound_payments/:identity/actions/cancel'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'outbound_payments' => {

            'amount' => 'amount-input',
            'created_at' => 'created_at-input',
            'description' => 'description-input',
            'execution_date' => 'execution_date-input',
            'id' => 'id-input',
            'is_withdrawal' => 'is_withdrawal-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'reference' => 'reference-input',
            'scheme' => 'scheme-input',
            'status' => 'status-input',
            'verifications' => 'verifications-input'
          }
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::OutboundPayment)

      expect(stub).to have_been_requested
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:post_response) { client.outbound_payments.cancel(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /outbound_payments/%v/actions/cancel
        stub_url = '/outbound_payments/:identity/actions/cancel'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/)
          .with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'outbound_payments' => {

                'amount' => 'amount-input',
                'created_at' => 'created_at-input',
                'description' => 'description-input',
                'execution_date' => 'execution_date-input',
                'id' => 'id-input',
                'is_withdrawal' => 'is_withdrawal-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'reference' => 'reference-input',
                'scheme' => 'scheme-input',
                'status' => 'status-input',
                'verifications' => 'verifications-input'
              }
            }.to_json,
            headers: response_headers
          )
      end
    end
  end

  describe '#approve' do
    subject(:post_response) { client.outbound_payments.approve(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /outbound_payments/%v/actions/approve
      stub_url = '/outbound_payments/:identity/actions/approve'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'outbound_payments' => {

            'amount' => 'amount-input',
            'created_at' => 'created_at-input',
            'description' => 'description-input',
            'execution_date' => 'execution_date-input',
            'id' => 'id-input',
            'is_withdrawal' => 'is_withdrawal-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'reference' => 'reference-input',
            'scheme' => 'scheme-input',
            'status' => 'status-input',
            'verifications' => 'verifications-input'
          }
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::OutboundPayment)

      expect(stub).to have_been_requested
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:post_response) { client.outbound_payments.approve(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /outbound_payments/%v/actions/approve
        stub_url = '/outbound_payments/:identity/actions/approve'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/)
          .with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'outbound_payments' => {

                'amount' => 'amount-input',
                'created_at' => 'created_at-input',
                'description' => 'description-input',
                'execution_date' => 'execution_date-input',
                'id' => 'id-input',
                'is_withdrawal' => 'is_withdrawal-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'reference' => 'reference-input',
                'scheme' => 'scheme-input',
                'status' => 'status-input',
                'verifications' => 'verifications-input'
              }
            }.to_json,
            headers: response_headers
          )
      end
    end
  end

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.outbound_payments.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/outbound_payments/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/)
          .with(headers: { 'Foo' => 'Bar' })
          .to_return(
            body: {
              'outbound_payments' => {

                'amount' => 'amount-input',
                'created_at' => 'created_at-input',
                'description' => 'description-input',
                'execution_date' => 'execution_date-input',
                'id' => 'id-input',
                'is_withdrawal' => 'is_withdrawal-input',
                'links' => 'links-input',
                'metadata' => 'metadata-input',
                'reference' => 'reference-input',
                'scheme' => 'scheme-input',
                'status' => 'status-input',
                'verifications' => 'verifications-input'
              }
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.outbound_payments.get(id, headers: {
                                       'Foo' => 'Bar'
                                     })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a outbound_payment to return' do
      before do
        stub_url = '/outbound_payments/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'outbound_payments' => {

              'amount' => 'amount-input',
              'created_at' => 'created_at-input',
              'description' => 'description-input',
              'execution_date' => 'execution_date-input',
              'id' => 'id-input',
              'is_withdrawal' => 'is_withdrawal-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'reference' => 'reference-input',
              'scheme' => 'scheme-input',
              'status' => 'status-input',
              'verifications' => 'verifications-input'
            }
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::OutboundPayment)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/outbound_payments/:identity'.gsub(':identity', id)
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

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.outbound_payments.list }

      before do
        stub_request(:get, %r{.*api.gocardless.com/outbound_payments}).to_return(
          body: {
            'outbound_payments' => [{

              'amount' => 'amount-input',
              'created_at' => 'created_at-input',
              'description' => 'description-input',
              'execution_date' => 'execution_date-input',
              'id' => 'id-input',
              'is_withdrawal' => 'is_withdrawal-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'reference' => 'reference-input',
              'scheme' => 'scheme-input',
              'status' => 'status-input',
              'verifications' => 'verifications-input'
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
        expect(get_list_response.records.map do |x|
                 x.class
               end.uniq.first).to eq(GoCardlessPro::Resources::OutboundPayment)

        expect(get_list_response.records.first.amount).to eq('amount-input')

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.description).to eq('description-input')

        expect(get_list_response.records.first.execution_date).to eq('execution_date-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.is_withdrawal).to eq('is_withdrawal-input')

        expect(get_list_response.records.first.metadata).to eq('metadata-input')

        expect(get_list_response.records.first.reference).to eq('reference-input')

        expect(get_list_response.records.first.scheme).to eq('scheme-input')

        expect(get_list_response.records.first.status).to eq('status-input')

        expect(get_list_response.records.first.verifications).to eq('verifications-input')
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
      stub_request(:get, %r{.*api.gocardless.com/outbound_payments$}).to_return(
        body: {
          'outbound_payments' => [{

            'amount' => 'amount-input',
            'created_at' => 'created_at-input',
            'description' => 'description-input',
            'execution_date' => 'execution_date-input',
            'id' => 'id-input',
            'is_withdrawal' => 'is_withdrawal-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'reference' => 'reference-input',
            'scheme' => 'scheme-input',
            'status' => 'status-input',
            'verifications' => 'verifications-input'
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
      stub_request(:get, %r{.*api.gocardless.com/outbound_payments\?after=AB345}).to_return(
        body: {
          'outbound_payments' => [{

            'amount' => 'amount-input',
            'created_at' => 'created_at-input',
            'description' => 'description-input',
            'execution_date' => 'execution_date-input',
            'id' => 'id-input',
            'is_withdrawal' => 'is_withdrawal-input',
            'links' => 'links-input',
            'metadata' => 'metadata-input',
            'reference' => 'reference-input',
            'scheme' => 'scheme-input',
            'status' => 'status-input',
            'verifications' => 'verifications-input'
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
      expect(client.outbound_payments.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end

  describe '#update' do
    subject(:put_update_response) { client.outbound_payments.update(id, params: update_params) }
    let(:id) { 'ABC123' }

    context 'with a valid request' do
      let(:update_params) { { 'hello' => 'world' } }

      let!(:stub) do
        stub_url = '/outbound_payments/:identity'.gsub(':identity', id)
        stub_request(:put, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'outbound_payments' => {

              'amount' => 'amount-input',
              'created_at' => 'created_at-input',
              'description' => 'description-input',
              'execution_date' => 'execution_date-input',
              'id' => 'id-input',
              'is_withdrawal' => 'is_withdrawal-input',
              'links' => 'links-input',
              'metadata' => 'metadata-input',
              'reference' => 'reference-input',
              'scheme' => 'scheme-input',
              'status' => 'status-input',
              'verifications' => 'verifications-input'
            }
          }.to_json,
          headers: response_headers
        )
      end

      it 'updates and returns the resource' do
        expect(put_update_response).to be_a(GoCardlessPro::Resources::OutboundPayment)
        expect(stub).to have_been_requested
      end
    end
  end
end
