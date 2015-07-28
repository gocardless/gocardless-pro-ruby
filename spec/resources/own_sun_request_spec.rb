require 'spec_helper'

describe GoCardlessPro::Resources::OwnSunRequest do
  describe "initialising" do
    let(:data) do
      {
      
      }
    end

    it "can be initialized from an uneveloped response" do
      resource = described_class.new(data)
      
    end

    describe "#to_h" do
      it "returns a hash representing the resource" do
        expect(described_class.new(data).to_h).to eq(data)
      end
    end
  end
end

