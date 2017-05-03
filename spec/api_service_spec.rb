require 'spec_helper'

describe GoCardlessPro::ApiService do
  subject(:service) { described_class.new('https://api.example.com', 'secret_token') }

  let(:default_response) do
    {
      status: 200,
      body: '{}',
      headers: { 'Content-Type' => 'application/json' }
    }
  end

  it 'uses basic auth' do
    stub = stub_request(:get, 'https://api.example.com/customers')
           .with(headers: { 'Authorization' => 'Bearer secret_token' })
           .to_return(default_response)

    service.make_request(:get, '/customers')
    expect(stub).to have_been_requested
  end

  describe 'making a get request without any parameters' do
    it 'is expected to call the correct stub' do
      stub = stub_request(:get, /.*api.example.com\/customers/)
             .to_return(default_response)

      service.make_request(:get, '/customers')
      expect(stub).to have_been_requested
    end

    it "doesn't include an idempotency key" do
      stub = stub_request(:get, /.*api.example.com\/customers/)
             .with { |request| !request.headers.key?('Idempotency-Key') }
             .to_return(default_response)

      service.make_request(:get, '/customers')
      expect(stub).to have_been_requested
    end
  end

  describe 'making a get request with query parameters' do
    it 'correctly passes the query parameters' do
      stub = stub_request(:get, /.*api.example.com\/customers\?a=1&b=2/)
             .to_return(default_response)

      service.make_request(:get, '/customers', params: { a: 1, b: 2 })
      expect(stub).to have_been_requested
    end

    it "doesn't include an idempotency key" do
      stub = stub_request(:get, /.*api.example.com\/customers\?a=1&b=2/)
             .with { |request| !request.headers.key?('Idempotency-Key') }
             .to_return(default_response)

      service.make_request(:get, '/customers', params: { a: 1, b: 2 })
      expect(stub).to have_been_requested
    end
  end

  describe 'making a post request with some data' do
    it 'passes the data in as the post body' do
      stub = stub_request(:post, /.*api.example.com\/customers/)
             .with(body: { given_name: 'Jack', family_name: 'Franklin' })
             .to_return(default_response)

      service.make_request(:post, '/customers', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin'
                           })
      expect(stub).to have_been_requested
    end

    it 'generates a random idempotency key' do
      allow(SecureRandom).to receive(:uuid).and_return('random-uuid')

      stub = stub_request(:post, /.*api.example.com\/customers/)
             .with(
               body: { given_name: 'Jack', family_name: 'Franklin' },
               headers: { 'Idempotency-Key' => 'random-uuid' }
             )
             .to_return(default_response)

      service.make_request(:post, '/customers', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin'
                           })
      expect(stub).to have_been_requested
    end
  end

  describe 'making a post request with data and custom header' do
    it 'passes the data in as the post body' do
      stub = stub_request(:post, /.*api.example.com\/customers/)
             .with(
               body: { given_name: 'Jack', family_name: 'Franklin' },
               headers: { 'Foo' => 'Bar' }
             )
             .to_return(default_response)

      service.make_request(:post, '/customers', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin'
                           },
                                                headers: {
                                                  'Foo' => 'Bar'
                                                })
      expect(stub).to have_been_requested
    end

    it 'merges in a random idempotency key' do
      allow(SecureRandom).to receive(:uuid).and_return('random-uuid')

      stub = stub_request(:post, /.*api.example.com\/customers/)
             .with(
               body: { given_name: 'Jack', family_name: 'Franklin' },
               headers: { 'Idempotency-Key' => 'random-uuid', 'Foo' => 'Bar' }
             )
             .to_return(default_response)

      service.make_request(:post, '/customers', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin'
                           },
                                                headers: {
                                                  'Foo' => 'Bar'
                                                })
      expect(stub).to have_been_requested
    end

    context 'with a custom idempotency key' do
      it "doesn't replace it with a randomly-generated idempotency key" do
        stub = stub_request(:post, /.*api.example.com\/customers/)
               .with(
                 body: { given_name: 'Jack', family_name: 'Franklin' },
                 headers: { 'Idempotency-Key' => 'my-custom-idempotency-key' }
               )
               .to_return(default_response)

        service.make_request(:post, '/customers', params: {
                               given_name: 'Jack',
                               family_name: 'Franklin'
                             },
                                                  headers: {
                                                    'Idempotency-Key' => 'my-custom-idempotency-key'
                                                  })
        expect(stub).to have_been_requested
      end
    end
  end

  describe 'making a put request with some data' do
    it 'passes the data in as the request body' do
      stub = stub_request(:put, /.*api.example.com\/customers\/CU123/)
             .with(body: { given_name: 'Jack', family_name: 'Franklin' })
             .to_return(default_response)

      service.make_request(:put, '/customers/CU123', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin'
                           })
      expect(stub).to have_been_requested
    end

    it "doesn't include an idempotency key" do
      stub = stub_request(:put, /.*api.example.com\/customers\/CU123/)
             .with { |request| !request.headers.key?('Idempotency-Key') }
             .to_return(default_response)

      service.make_request(:put, '/customers/CU123', params: {
                             given_name: 'Jack',
                             family_name: 'Franklin'
                           })
      expect(stub).to have_been_requested
    end
  end
end
