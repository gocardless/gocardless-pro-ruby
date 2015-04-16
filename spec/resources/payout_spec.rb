require 'spec_helper'

describe GoCardless::Resources::Payout do
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

    it "can be initialized from an uneveloped response" do
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
  end
end

