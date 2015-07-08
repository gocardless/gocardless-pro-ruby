require 'spec_helper'
require 'json'

describe GoCardlessPro::ApiResponse do
  describe "wrapping a Faraday response" do
    let(:content_type) { 'application/json' }

    let(:stubbed) do
      Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/testing') do |env|
          [200, { 'Content-Type' => content_type}, { test: true }.to_json]
        end
      end
    end
    let(:test) { Faraday.new { |builder| builder.adapter :test, stubbed } }
    subject(:api_response) do
      described_class.new(
        GoCardlessPro::Response.new(test.get('/testing'))
      )
    end

    specify { expect(api_response.status_code).to eql(200) }
    specify do
      expect(api_response.headers).to eql('Content-Type' => content_type)
    end
    specify { expect(api_response.body).to eql("test" => true) }
  end
end
