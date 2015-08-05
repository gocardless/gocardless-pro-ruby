require 'spec_helper'

describe GoCardlessPro::Response do

  subject(:response) { described_class.new(raw_response) }
  let(:default_headers) do
    { 'Content-Type' => 'application/json' }
  end

  context "when the response is not an error" do
    let(:raw_response) do
      double("response",
        headers: default_headers,
        status: 200,
        body: { customers: [] }.to_json
      )
    end

    it "returns the body parsed into a hash" do
      expect(response.body).to eq("customers" => [])
    end
  end

  context "when the response is empty" do
    let(:raw_response) do
      double("response", headers: default_headers, status: 204, body: '')
    end

    it "returns nil" do
      expect(response.body).to be_nil
    end
  end

  context "when the resonse is a validation error" do
    let(:raw_response) do
      double("response",
        headers: default_headers,
        status: 400,
        body: { error: { type: 'validation_failed' } }.to_json
      )
    end

    it "raises a ValidationError" do
      expect { response.body }.to raise_error(GoCardlessPro::ValidationError)
    end
  end

  context "when the resonse is a gocardless error" do
    let(:raw_response) do
      double("response",
        headers: default_headers,
        status: 400,
        body: { error: { type: 'gocardless' } }.to_json
      )
    end

    it "raises a ValidationError" do
      expect { response.body }.to raise_error(GoCardlessPro::GoCardlessError)
    end
  end

  context "when the resonse is an invalid api usage error" do
    let(:raw_response) do
      double("response",
        headers: default_headers,
        status: 400,
        body: { error: { type: 'invalid_api_usage' } }.to_json
      )
    end

    it "raises a ValidationError" do
      expect { response.body }.to raise_error(GoCardlessPro::InvalidApiUsageError)
    end
  end

  context "when the response isn't JSON" do
    let(:raw_response) do
      double("response",
        headers: {},
        status: 400,
        body: '',
      )
    end

    it "raises an ApiError" do
      expect { response.body }.to raise_error(GoCardlessPro::ApiError)
    end
  end

  context "when the response is an invalid state error" do
    let(:raw_response) do
      double("response",
        headers: default_headers,
        status: 400,
        body: { error: { type: 'invalid_state' } }.to_json
      )
    end

    it "raises a ValidationError" do
      expect { response.body }.to raise_error(GoCardlessPro::InvalidStateError)
    end
  end
end
