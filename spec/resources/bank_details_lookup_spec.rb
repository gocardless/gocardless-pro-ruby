require 'spec_helper'

describe GoCardlessPro::Resources::BankDetailsLookup do
  describe "initialising" do
    let(:data) do
      {
      
        
          "available_debit_schemes" => "available_debit_schemes-input",
        
      
        
          "bank_name" => "bank_name-input",
        
      
        
          "bic" => "bic-input",
        
      
      }
    end

    it "can be initialized from an unenveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.available_debit_schemes).to eq("available_debit_schemes-input")
       
       
       
       expect(resource.bank_name).to eq("bank_name-input")
       
       
       
       expect(resource.bic).to eq("bic-input")
       
       
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
