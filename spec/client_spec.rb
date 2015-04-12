require 'spec_helper'

describe GoCardless::Client do
  subject { -> { described_class.new(options) } }

  let(:options) do
    {
      environment: environment,
      api_key: api_key,
      api_secret: api_secret
    }
  end

  context "when initialised without an API key" do
    let(:environment) { :production }
    let(:api_secret) { "MYSECRETTOKEN" }
    let(:api_key) { nil }

    it { is_expected.to raise_error("No API key ID given to GoCardless Client") }
  end

  context "when initialised without an API secret" do
    let(:api_secret) { nil }
    let(:environment) { :production }
    let(:api_key) { "AK123" }

    it { is_expected.to raise_error("No API secret given to GoCardless Client") }
  end
end
