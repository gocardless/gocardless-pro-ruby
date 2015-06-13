require 'spec_helper'

describe GoCardlessPro::ApiService do
  subject(:service) { described_class.new("https://api.example.com", "secret_token") }

  it "uses basic auth" do
    stub = stub_request(:get, 'https://api.example.com/customers').
      with(headers: { "Authorization" => "Bearer secret_token" })
    service.make_request(:get, "/customers")
    expect(stub).to have_been_requested
  end

  describe "making a get request without any parameters" do
    it "is expected to call the correct stub" do
      stub = stub_request(:get, /.*api.example.com\/customers/)
      service.make_request(:get, "/customers")
      expect(stub).to have_been_requested
    end
  end

  describe "making a get request with query parameters" do
    it "correctly passes the query parameters" do
      stub = stub_request(:get, /.*api.example.com\/customers\?a=1&b=2/)
      service.make_request(:get, "/customers", params: { a: 1, b: 2 })
      expect(stub).to have_been_requested
    end
  end

  describe "making a post request with some data" do
    it "passes the data in as the post body" do
      stub = stub_request(:post, /.*api.example.com\/customers/).
        with(body: { given_name: "Jack", family_name: "Franklin" })
      service.make_request(:post, "/customers", params: {
        given_name: "Jack",
        family_name: "Franklin"
      })
      expect(stub).to have_been_requested
    end
  end

  describe "making a post request with data and custom header" do
    it "passes the data in as the post body" do
      stub = stub_request(:post, /.*api.example.com\/customers/).
        with(
          body: { given_name: "Jack", family_name: "Franklin" },
          headers: { 'Foo' => 'Bar' }
        )

      service.make_request(:post, "/customers", {
        params: {
          given_name: "Jack",
          family_name: "Franklin"
        },
        headers: {
          'Foo' => 'Bar'
        }
      })
      expect(stub).to have_been_requested
    end
  end

  describe "making a put request with some data" do
    it "passes the data in as the request body" do
      stub = stub_request(:put, /.*api.example.com\/customers\/CU123/).
        with(body: { given_name: "Jack", family_name: "Franklin" })
      service.make_request(:put, "/customers/CU123", params: {
        given_name: "Jack",
        family_name: "Franklin"
      })
      expect(stub).to have_been_requested
    end
  end
end
