require 'spec_helper'

describe "TESTS" do
  before do
    stub_request(:get, 'https://AK123:ABC@api.gocardless.com/customers').to_return(
      body: {
        customers: [
          {
            id: "CU123",
            given_name: "jack",
            family_name: "franklin"
          }
        ]
      }.to_json,
      :headers => {'Content-Type' => 'application/json'}
    )
  end


  it "can get customers" do
    client = GoCardless::Client.new(
      user: "AK123",
      password: "ABC"
    )

    expect(client.customers.list.to_a.count).to eq(1)
  end
end
