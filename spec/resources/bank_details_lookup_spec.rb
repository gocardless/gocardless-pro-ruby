require 'spec_helper'

describe GoCardlessPro::Resources::BankDetailsLookup do
  describe "initialising" do
    let(:data) do
      {
      
        
          "available_debit_schemes" => "available_debit_schemes-input",
        
      
        
          "bank_name" => "bank_name-input",
        
      
      }
    end

    it "can be initialized from an uneveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.available_debit_schemes).to eq("available_debit_schemes-input")
       
       
       
       expect(resource.bank_name).to eq("bank_name-input")
       
       
    end

    describe "#to_h" do
      it "returns a hash representing the resource" do
        expect(described_class.new(data).to_h).to eq(data)
      end
    end
  end
end

