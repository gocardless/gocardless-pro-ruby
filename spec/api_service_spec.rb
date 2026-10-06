require 'spec_helper'

describe GoCardlessPro::ApiService do
  subject(:service) do
    described_class.new('https://api.example.com', 'secret_token', options)
  end

  let(:options) { {} }
  let(:default_response) do
    {
      status: 200,
      body: '{}',
      headers: { 'Content-Type' => 'application/json' },
    }
  end

  it 'uses basic auth' do
    stub = stub_request(:get, 'https://api.example.com/customers').
           with(headers: { 'Authorization' => 'Bearer secret_token' }).
           to_return(default_response)

    service.make_request(:get, '/customers')
    expect(stub).to have_been_requested
  end

  describe 'making a get request without any parameters' do
    it 'is expected to call the correct stub' do
      stub = stub_request(:get, %r{.*api.example.com/customers}).
             to_return(default_response)

      service.make_request(:get, '/customers')
      expect(stub).to have_been_requested
    end

    it "doesn't include an idempotency key" do
      stub = stub_request(:get, %r{.*api.example.com/customers}).
             with { |request| !request.headers.key?('Idempotency-Key') }.
             to_return(default_response)

      service.make_request(:get, '/customers')
      expect(stub).to have_been_requested
    end
  end

  describe 'making a get request with query parameters' do
    it 'correctly passes the query parameters' do
      stub = stub_request(:get, %r{.*api.example.com/customers\?a=1&b=2}).
             to_return(default_response)

      service.make_request(:get, '/customers', params: { a: 1, b: 2 })
      expect(stub).to have_been_requested
    end

    it "doesn't include an idempotency key" do
      stub = stub_request(:get, %r{.*api.example.com/customers\?a=1&b=2}).
             with { |request| !request.headers.key?('Idempotency-Key') }.
             to_return(default_response)

      service.make_request(:get, '/customers', params: { a: 1, b: 2 })
      expect(stub).to have_been_requested
    end
  end

  describe 'making a post request with some data' do
    it 'passes the data in as the post body' do
      stub = stub_request(:post, %r{.*api.example.com/customers}).
             with(body: { given_name: 'Jack', family_name: 'Franklin' }).
             to_return(default_response)

      service.make_request(:post, '/customers', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin',
                           })
      expect(stub).to have_been_requested
    end

    it 'generates a random idempotency key' do
      allow(SecureRandom).to receive(:uuid).and_return('random-uuid')

      stub = stub_request(:post, %r{.*api.example.com/customers}).
             with(
               body: { given_name: 'Jack', family_name: 'Franklin' },
               headers: { 'Idempotency-Key' => 'random-uuid' }
             ).
             to_return(default_response)

      service.make_request(:post, '/customers', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin',
                           })
      expect(stub).to have_been_requested
    end
  end

  describe 'making a post request with data and custom header' do
    it 'passes the data in as the post body' do
      stub = stub_request(:post, %r{.*api.example.com/customers}).
             with(
               body: { given_name: 'Jack', family_name: 'Franklin' },
               headers: { 'Foo' => 'Bar' }
             ).
             to_return(default_response)

      service.make_request(:post, '/customers', {
                             params: {
                               given_name: 'Jack',
                               family_name: 'Franklin',
                             },
                             headers: {
                               'Foo' => 'Bar',
                             },
                           })
      expect(stub).to have_been_requested
    end

    it 'merges in a random idempotency key' do
      allow(SecureRandom).to receive(:uuid).and_return('random-uuid')

      stub = stub_request(:post, %r{.*api.example.com/customers}).
             with(
               body: { given_name: 'Jack', family_name: 'Franklin' },
               headers: { 'Idempotency-Key' => 'random-uuid', 'Foo' => 'Bar' }
             ).
             to_return(default_response)

      service.make_request(:post, '/customers', {
                             params: {
                               given_name: 'Jack',
                               family_name: 'Franklin',
                             },
                             headers: {
                               'Foo' => 'Bar',
                             },
                           })
      expect(stub).to have_been_requested
    end

    context 'with a custom idempotency key' do
      it "doesn't replace it with a randomly-generated idempotency key" do
        stub = stub_request(:post, %r{.*api.example.com/customers}).
               with(
                 body: { given_name: 'Jack', family_name: 'Franklin' },
                 headers: { 'Idempotency-Key' => 'my-custom-idempotency-key' }
               ).
               to_return(default_response)

        service.make_request(:post, '/customers', {
                               params: {
                                 given_name: 'Jack',
                                 family_name: 'Franklin',
                               },
                               headers: {
                                 'Idempotency-Key' => 'my-custom-idempotency-key',
                               },
                             })
        expect(stub).to have_been_requested
      end
    end
  end

  describe 'making a put request with some data' do
    it 'passes the data in as the request body' do
      stub = stub_request(:put, %r{.*api.example.com/customers/CU123}).
             with(body: { given_name: 'Jack', family_name: 'Franklin' }).
             to_return(default_response)

      service.make_request(:put, '/customers/CU123', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin',
                           })
      expect(stub).to have_been_requested
    end

    it "doesn't include an idempotency key" do
      stub = stub_request(:put, %r{.*api.example.com/customers/CU123}).
             with { |request| !request.headers.key?('Idempotency-Key') }.
             to_return(default_response)

      service.make_request(:put, '/customers/CU123', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin',
                           })
      expect(stub).to have_been_requested
    end
  end

  describe 'when passing an invalid :on_idempotency_conflict' do
    let(:options) { { on_idempotency_conflict: :junk } }

    it 'raises an error' do
      expect { service }.to raise_error(ArgumentError)
    end
  end

  describe 'request path validation' do
    # An absolute URL in the path would replace the configured API URL while the
    # Authorization header is still attached, handing the token to whichever host the URL
    # names, so these are rejected before a request is made.
    it 'rejects an absolute URL' do
      stub = stub_request(:get, 'http://elsewhere.example.com/capture').
             to_return(default_response)

      expect { service.make_request(:get, 'http://elsewhere.example.com/capture') }.
        to raise_error(ArgumentError)
      expect(stub).to_not have_been_requested
    end

    it 'rejects a scheme-relative URL' do
      stub = stub_request(:get, 'https://elsewhere.example.com/capture').
             to_return(default_response)

      expect { service.make_request(:get, '//elsewhere.example.com/capture') }.
        to raise_error(ArgumentError)
      expect(stub).to_not have_been_requested
    end

    it 'rejects an absolute URL for every verb' do
      %i[get post put delete].each do |method|
        expect { service.make_request(method, 'http://elsewhere.example.com/capture') }.
          to raise_error(ArgumentError)
      end
    end

    it 'rejects a path URI.parse cannot read' do
      expect { service.make_request(:get, "\thttp://elsewhere.example.com/capture") }.
        to raise_error(ArgumentError)
    end

    it 'allows a relative path with a query string' do
      # Request#make_request assigns `request.params` itself, so a query string embedded in
      # the path is dropped before the request goes out - query params belong in
      # options[:params]. What matters here is that such a path is accepted rather than
      # rejected as if it named a host.
      stub = stub_request(:get, 'https://api.example.com/customers').
             to_return(default_response)

      service.make_request(:get, '/customers?page=1')
      expect(stub).to have_been_requested
    end

    it 'keeps dot segments on the configured API URL' do
      # Dot segments resolve against the base URL, so they can reach another path on the same
      # origin but cannot leave it. They are allowed through, and this pins that behaviour.
      stub = stub_request(:get, 'https://api.example.com/other').to_return(default_response)

      service.make_request(:get, '/customers/../other')
      expect(stub).to have_been_requested
    end
  end
end
