require 'spec_helper'

describe GoCardlessPro::Resources::ModulusCheck do
  describe "initialising" do
    let(:data) do
      {
      
        
          "available_schemes" => "available_schemes-input",
        
      
        
          "errors" => "errors-input",
        
      
        
          "succeeded" => "succeeded-input",
        
      
      }
    end

    it "can be initialized from an uneveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.available_schemes).to eq("available_schemes-input")
       
       
       
       expect(resource.errors).to eq("errors-input")
       
       
       
       expect(resource.succeeded).to eq("succeeded-input")
       
       
    end

    describe "#to_h" do
      it "returns a hash representing the resource" do
        expect(described_class.new(data).to_h).to eq(data)
      end
    end
  end
end

