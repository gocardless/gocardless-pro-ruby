require 'spec_helper'

describe GoCardlessPro::Client do
  subject { -> { described_class.new(options) } }

  let(:options) do
    {
      environment: environment,
      token: token
    }
  end

  context "when initialised without an Access Token" do
    let(:environment) { :live }
    let(:token) { nil }

    it { is_expected.to raise_error("No Access Token given to GoCardless Client") }
  end
end
