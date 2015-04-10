require 'spec_helper'

describe GoCardless::Client do
  subject { -> { described_class.new(options) } }

  let(:options) do
    {
      environment: environment,
      user: user,
      password: password
    }
  end

  context "when initialised without an API key" do
    let(:environment) { :production }
    let(:password) { "MYSECRETTOKEN" }
    let(:user) { nil }

    it { is_expected.to raise_error("No API key ID given to GoCardless Client") }
  end

  context "when initialised without an API secret" do
    let(:password) { nil }
    let(:environment) { :production }
    let(:user) { "AK123" }

    it { is_expected.to raise_error("No API secret given to GoCardless Client") }
  end
end
