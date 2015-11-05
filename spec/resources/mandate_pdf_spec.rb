require 'spec_helper'

describe GoCardlessPro::Resources::MandatePdf do
  describe "initialising" do
    let(:data) do
      {
      
        
          "expires_at" => "expires_at-input",
        
      
        
          "url" => "url-input",
        
      
      }
    end

    it "can be initialized from an unenveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.expires_at).to eq("expires_at-input")
       
       
       
       expect(resource.url).to eq("url-input")
       
       
    end

    it "can handle new attributes without erroring" do
      data["foo"] = "bar"
      expect { described_class.new(data) }.to_not raise_error
    end

    

    describe "#to_h" do
      it "returns a hash representing the resource" do
        expect(described_class.new(data).to_h).to eq(data)
      end
    end
  end
end
