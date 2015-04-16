require 'spec_helper'

describe GoCardless::Resources::Refund do
  describe "initialising" do
    let(:data) do
      {
      
        
          "amount" => "amount-input",
        
      
        
          "created_at" => "created_at-input",
        
      
        
          "currency" => "currency-input",
        
      
        
          "id" => "id-input",
        
      
        
        "links" => {
          
            "payment" => "payment-input",
          
        },
        
      
        
          "metadata" => "metadata-input",
        
      
      }
    end

    it "can be initialized from an uneveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.amount).to eq("amount-input")
       
       
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.currency).to eq("currency-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
         
           expect(resource.links.payment).to eq("payment-input")
         
       
       
       
       expect(resource.metadata).to eq("metadata-input")
       
       
    end
  end
end

