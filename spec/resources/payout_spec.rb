require 'spec_helper'

describe GoCardlessPro::Resources::Payout do
  describe "initialising" do
    let(:data) do
      {
      
        
          "amount" => "amount-input",
        
      
        
          "created_at" => "created_at-input",
        
      
        
          "currency" => "currency-input",
        
      
        
          "id" => "id-input",
        
      
        
        "links" => {
          
            "creditor" => "creditor-input",
          
            "creditor_bank_account" => "creditor_bank_account-input",
          
        },
        
      
        
          "reference" => "reference-input",
        
      
        
          "status" => "status-input",
        
      
      }
    end

    it "can be initialized from an unenveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.amount).to eq("amount-input")
       
       
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.currency).to eq("currency-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
         
           expect(resource.links.creditor).to eq("creditor-input")
         
           expect(resource.links.creditor_bank_account).to eq("creditor_bank_account-input")
         
       
       
       
       expect(resource.reference).to eq("reference-input")
       
       
       
       expect(resource.status).to eq("status-input")
       
       
    end

    it "can handle new attributes without erroring" do
      data["foo"] = "bar"
      expect { described_class.new(data) }.to_not raise_error
    end

    
    it "can handle new link attributes without erroring" do
      data["links"]["foo"] = "bar"
      expect { described_class.new(data) }.to_not raise_error
    end

    it "can handle a nil links value" do
      data["links"] = nil
      expect { described_class.new(data).links }.to_not raise_error
    end
    

    describe "#to_h" do
      it "returns a hash representing the resource" do
        expect(described_class.new(data).to_h).to eq(data)
      end
    end
  end
end
