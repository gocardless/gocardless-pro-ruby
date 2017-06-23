require 'spec_helper'

describe GoCardlessPro::Response do
  subject(:response) { described_class.new(raw_response) }

  let(:default_headers) do
    { 'Content-Type' => 'application/json' }
  end

  describe '#body' do
    subject(:body) { response.body }

    let(:raw_response) do
      double('response',
             headers: default_headers,
             status: 200,
             body: { customers: [] }.to_json)
    end

    it 'returns the body parsed into a hash' do
      expect(body).to eq('customers' => [])
    end

    context 'when the response is empty' do
      let(:raw_response) do
        double('response', headers: default_headers, status: 204, body: '')
      end

      it 'returns nil' do
        expect(body).to be_nil
      end
    end
  end
end
