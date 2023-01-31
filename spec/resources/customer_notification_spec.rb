require 'spec_helper'

describe GoCardlessPro::Resources::CustomerNotification do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#handle' do
    subject(:post_response) { client.customer_notifications.handle(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /customer_notifications/%v/actions/handle
      stub_url = '/customer_notifications/:identity/actions/handle'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
        body: {
          'customer_notifications' => {

            'action_taken' => 'action_taken-input',
            'action_taken_at' => 'action_taken_at-input',
            'action_taken_by' => 'action_taken_by-input',
            'id' => 'id-input',
            'links' => 'links-input',
            'type' => 'type-input',
          },
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::CustomerNotification)

      expect(stub).to have_been_requested
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:post_response) { client.customer_notifications.handle(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /customer_notifications/%v/actions/handle
        stub_url = '/customer_notifications/:identity/actions/handle'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'customer_notifications' => {

                'action_taken' => 'action_taken-input',
                'action_taken_at' => 'action_taken_at-input',
                'action_taken_by' => 'action_taken_by-input',
                'id' => 'id-input',
                'links' => 'links-input',
                'type' => 'type-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
