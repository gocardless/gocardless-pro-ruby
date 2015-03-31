require 'spec_helper'

describe "TESTS" do
  it "can get customers" do
    GoCardless::Enterprise.connect("https://api-staging.gocardless.com", "AK000010TVVB60", "R-8iFkESHpBAune32sEQV5vihyR7e5Of7Gnqw0PW")
    expect(GoCardless::Enterprise.customers.list.to_a.count).to eq(24)
  end
end
