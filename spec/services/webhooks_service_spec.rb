require 'spec_helper'

describe GoCardlessPro::Services::WebhooksService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.webhooks.list }

      let(:body) do
        {
          'webhooks' => [{

            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'is_test' => 'is_test-input',
            'request_body' => 'request_body-input',
            'request_headers' => 'request_headers-input',
            'response_body' => 'response_body-input',
            'response_body_truncated' => 'response_body_truncated-input',
            'response_code' => 'response_code-input',
            'response_headers' => 'response_headers-input',
            'response_headers_content_truncated' => 'response_headers_content_truncated-input',
            'response_headers_count_truncated' => 'response_headers_count_truncated-input',
            'successful' => 'successful-input',
            'url' => 'url-input',
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
        stub_request(:get, %r{.*api.gocardless.com/webhooks}).to_return(
          body: body,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map(&:class).uniq.first).to eq(GoCardlessPro::Resources::Webhook)

        expect(get_list_response.records.first.created_at).to eq('created_at-input')

        expect(get_list_response.records.first.id).to eq('id-input')

        expect(get_list_response.records.first.is_test).to eq('is_test-input')

        expect(get_list_response.records.first.request_body).to eq('request_body-input')

        expect(get_list_response.records.first.request_headers).to eq('request_headers-input')

        expect(get_list_response.records.first.response_body).to eq('response_body-input')

        expect(get_list_response.records.first.response_body_truncated).to eq('response_body_truncated-input')

        expect(get_list_response.records.first.response_code).to eq('response_code-input')

        expect(get_list_response.records.first.response_headers).to eq('response_headers-input')

        expect(get_list_response.records.first.response_headers_content_truncated).to eq('response_headers_content_truncated-input')

        expect(get_list_response.records.first.response_headers_count_truncated).to eq('response_headers_count_truncated-input')

        expect(get_list_response.records.first.successful).to eq('successful-input')

        expect(get_list_response.records.first.url).to eq('url-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }

      describe 'retry behaviour' do
        before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

        it 'retries timeouts' do
          stub = stub_request(:get, %r{.*api.gocardless.com/webhooks}).
                 to_timeout.then.to_return(status: 200, headers: response_headers, body: body)

          get_list_response
          expect(stub).to have_been_requested.twice
        end

        it 'retries 5XX errors' do
          stub = stub_request(:get, %r{.*api.gocardless.com/webhooks}).
                 to_return(status: 502,
                           headers: { 'Content-Type' => 'text/html' },
                           body: '<html><body>Response from Cloudflare</body></html>').
                 then.to_return(status: 200, headers: response_headers, body: body)

          get_list_response
          expect(stub).to have_been_requested.twice
        end
      end
    end
  end

  describe '#all' do
    let!(:first_response_stub) do
      stub_request(:get, %r{.*api.gocardless.com/webhooks$}).to_return(
        body: {
          'webhooks' => [{

            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'is_test' => 'is_test-input',
            'request_body' => 'request_body-input',
            'request_headers' => 'request_headers-input',
            'response_body' => 'response_body-input',
            'response_body_truncated' => 'response_body_truncated-input',
            'response_code' => 'response_code-input',
            'response_headers' => 'response_headers-input',
            'response_headers_content_truncated' => 'response_headers_content_truncated-input',
            'response_headers_count_truncated' => 'response_headers_count_truncated-input',
            'successful' => 'successful-input',
            'url' => 'url-input',
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
      stub_request(:get, %r{.*api.gocardless.com/webhooks\?after=AB345}).to_return(
        body: {
          'webhooks' => [{

            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'is_test' => 'is_test-input',
            'request_body' => 'request_body-input',
            'request_headers' => 'request_headers-input',
            'response_body' => 'response_body-input',
            'response_body_truncated' => 'response_body_truncated-input',
            'response_code' => 'response_code-input',
            'response_headers' => 'response_headers-input',
            'response_headers_content_truncated' => 'response_headers_content_truncated-input',
            'response_headers_count_truncated' => 'response_headers_count_truncated-input',
            'successful' => 'successful-input',
            'url' => 'url-input',
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
      expect(client.webhooks.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/webhooks$}).to_return(
          body: {
            'webhooks' => [{

              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'is_test' => 'is_test-input',
              'request_body' => 'request_body-input',
              'request_headers' => 'request_headers-input',
              'response_body' => 'response_body-input',
              'response_body_truncated' => 'response_body_truncated-input',
              'response_code' => 'response_code-input',
              'response_headers' => 'response_headers-input',
              'response_headers_content_truncated' => 'response_headers_content_truncated-input',
              'response_headers_count_truncated' => 'response_headers_count_truncated-input',
              'successful' => 'successful-input',
              'url' => 'url-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/webhooks\?after=AB345}).
                               to_timeout.then.
                               to_return(
                                 body: {
                                   'webhooks' => [{

                                     'created_at' => 'created_at-input',
                                     'id' => 'id-input',
                                     'is_test' => 'is_test-input',
                                     'request_body' => 'request_body-input',
                                     'request_headers' => 'request_headers-input',
                                     'response_body' => 'response_body-input',
                                     'response_body_truncated' => 'response_body_truncated-input',
                                     'response_code' => 'response_code-input',
                                     'response_headers' => 'response_headers-input',
                                     'response_headers_content_truncated' => 'response_headers_content_truncated-input',
                                     'response_headers_count_truncated' => 'response_headers_count_truncated-input',
                                     'successful' => 'successful-input',
                                     'url' => 'url-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.webhooks.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end

      it 'retries 5XX errors' do
        first_response_stub = stub_request(:get, %r{.*api.gocardless.com/webhooks$}).to_return(
          body: {
            'webhooks' => [{

              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'is_test' => 'is_test-input',
              'request_body' => 'request_body-input',
              'request_headers' => 'request_headers-input',
              'response_body' => 'response_body-input',
              'response_body_truncated' => 'response_body_truncated-input',
              'response_code' => 'response_code-input',
              'response_headers' => 'response_headers-input',
              'response_headers_content_truncated' => 'response_headers_content_truncated-input',
              'response_headers_count_truncated' => 'response_headers_count_truncated-input',
              'successful' => 'successful-input',
              'url' => 'url-input',
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1,
            },
          }.to_json,
          headers: response_headers
        )

        second_response_stub = stub_request(:get, %r{.*api.gocardless.com/webhooks\?after=AB345}).
                               to_return(
                                 status: 502,
                                 body: '<html><body>Response from Cloudflare</body></html>',
                                 headers: { 'Content-Type' => 'text/html' }
                               ).then.to_return(
                                 body: {
                                   'webhooks' => [{

                                     'created_at' => 'created_at-input',
                                     'id' => 'id-input',
                                     'is_test' => 'is_test-input',
                                     'request_body' => 'request_body-input',
                                     'request_headers' => 'request_headers-input',
                                     'response_body' => 'response_body-input',
                                     'response_body_truncated' => 'response_body_truncated-input',
                                     'response_code' => 'response_code-input',
                                     'response_headers' => 'response_headers-input',
                                     'response_headers_content_truncated' => 'response_headers_content_truncated-input',
                                     'response_headers_count_truncated' => 'response_headers_count_truncated-input',
                                     'successful' => 'successful-input',
                                     'url' => 'url-input',
                                   }],
                                   meta: {
                                     limit: 2,
                                     cursors: {},
                                   },
                                 }.to_json,
                                 headers: response_headers
                               )

        client.webhooks.all.to_a

        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested.twice
      end
    end
  end

  describe '#get' do
    let(:id) { 'ID123' }

    subject(:get_response) { client.webhooks.get(id) }

    context 'passing in a custom header' do
      let!(:stub) do
        stub_url = '/webhooks/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              'webhooks' => {

                'created_at' => 'created_at-input',
                'id' => 'id-input',
                'is_test' => 'is_test-input',
                'request_body' => 'request_body-input',
                'request_headers' => 'request_headers-input',
                'response_body' => 'response_body-input',
                'response_body_truncated' => 'response_body_truncated-input',
                'response_code' => 'response_code-input',
                'response_headers' => 'response_headers-input',
                'response_headers_content_truncated' => 'response_headers_content_truncated-input',
                'response_headers_count_truncated' => 'response_headers_count_truncated-input',
                'successful' => 'successful-input',
                'url' => 'url-input',
              },
            }.to_json,
            headers: response_headers
          )
      end

      subject(:get_response) do
        client.webhooks.get(id, headers: {
                              'Foo' => 'Bar',
                            })
      end

      it 'includes the header' do
        get_response
        expect(stub).to have_been_requested
      end
    end

    context 'when there is a webhook to return' do
      before do
        stub_url = '/webhooks/:identity'.gsub(':identity', id)
        stub_request(:get, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            'webhooks' => {

              'created_at' => 'created_at-input',
              'id' => 'id-input',
              'is_test' => 'is_test-input',
              'request_body' => 'request_body-input',
              'request_headers' => 'request_headers-input',
              'response_body' => 'response_body-input',
              'response_body_truncated' => 'response_body_truncated-input',
              'response_code' => 'response_code-input',
              'response_headers' => 'response_headers-input',
              'response_headers_content_truncated' => 'response_headers_content_truncated-input',
              'response_headers_count_truncated' => 'response_headers_count_truncated-input',
              'successful' => 'successful-input',
              'url' => 'url-input',
            },
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps the response in a resource' do
        expect(get_response).to be_a(GoCardlessPro::Resources::Webhook)
      end
    end

    context 'when nothing is returned' do
      before do
        stub_url = '/webhooks/:identity'.gsub(':identity', id)
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

    describe 'retry behaviour' do
      before { allow_any_instance_of(GoCardlessPro::Request).to receive(:sleep) }

      it 'retries timeouts' do
        stub_url = '/webhooks/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_timeout.then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 5XX errors, other than 500s' do
        stub_url = '/webhooks/:identity'.gsub(':identity', id)

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_return(status: 502,
                         headers: { 'Content-Type' => 'text/html' },
                         body: '<html><body>Response from Cloudflare</body></html>').
               then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end

      it 'retries 500 errors returned by the API' do
        stub_url = '/webhooks/:identity'.gsub(':identity', id)

        gocardless_error = {
          'error' => {
            'message' => 'Internal server error',
            'documentation_url' => 'https://developer.gocardless.com/#gocardless',
            'errors' => [{
              'message' => 'Internal server error',
              'reason' => 'internal_server_error',
            }],
            'type' => 'gocardless',
            'code' => 500,
            'request_id' => 'dummy_request_id',
            'id' => 'dummy_exception_id',
          },
        }

        stub = stub_request(:get, /.*api.gocardless.com#{stub_url}/).
               to_return(status: 500,
                         headers: response_headers,
                         body: gocardless_error.to_json).
               then.to_return(status: 200, headers: response_headers)

        get_response
        expect(stub).to have_been_requested.twice
      end
    end
  end

  describe '#retry' do
    subject(:post_response) { client.webhooks.retry(resource_id) }

    let(:resource_id) { 'ABC123' }

    let!(:stub) do
      # /webhooks/%v/actions/retry
      stub_url = '/webhooks/:identity/actions/retry'.gsub(':identity', resource_id)
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(

        body: {
          'webhooks' => {

            'created_at' => 'created_at-input',
            'id' => 'id-input',
            'is_test' => 'is_test-input',
            'request_body' => 'request_body-input',
            'request_headers' => 'request_headers-input',
            'response_body' => 'response_body-input',
            'response_body_truncated' => 'response_body_truncated-input',
            'response_code' => 'response_code-input',
            'response_headers' => 'response_headers-input',
            'response_headers_content_truncated' => 'response_headers_content_truncated-input',
            'response_headers_count_truncated' => 'response_headers_count_truncated-input',
            'successful' => 'successful-input',
            'url' => 'url-input',
          },
        }.to_json,

        headers: response_headers
      )
    end

    it 'wraps the response and calls the right endpoint' do
      expect(post_response).to be_a(GoCardlessPro::Resources::Webhook)

      expect(stub).to have_been_requested
    end

    describe 'retry behaviour' do
      it "doesn't retry errors" do
        stub_url = '/webhooks/:identity/actions/retry'.gsub(':identity', resource_id)
        stub = stub_request(:post, /.*api.gocardless.com#{stub_url}/).
               to_timeout

        expect { post_response }.to raise_error(Faraday::ConnectionFailed)
        expect(stub).to have_been_requested
      end
    end

    context 'when the request needs a body and custom header' do
      let(:body) { { foo: 'bar' } }
      let(:headers) { { 'Foo' => 'Bar' } }
      subject(:post_response) { client.webhooks.retry(resource_id, body, headers) }

      let(:resource_id) { 'ABC123' }

      let!(:stub) do
        # /webhooks/%v/actions/retry
        stub_url = '/webhooks/:identity/actions/retry'.gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              'webhooks' => {

                'created_at' => 'created_at-input',
                'id' => 'id-input',
                'is_test' => 'is_test-input',
                'request_body' => 'request_body-input',
                'request_headers' => 'request_headers-input',
                'response_body' => 'response_body-input',
                'response_body_truncated' => 'response_body_truncated-input',
                'response_code' => 'response_code-input',
                'response_headers' => 'response_headers-input',
                'response_headers_content_truncated' => 'response_headers_content_truncated-input',
                'response_headers_count_truncated' => 'response_headers_count_truncated-input',
                'successful' => 'successful-input',
                'url' => 'url-input',
              },
            }.to_json,
            headers: response_headers
          )
      end
    end
  end
end
