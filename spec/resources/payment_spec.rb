require 'spec_helper'

describe GoCardlessPro::Resources::Payment do
  describe "initialising" do
    let(:data) do
      {
      
        
          "amount" => "amount-input",
        
      
        
          "amount_refunded" => "amount_refunded-input",
        
      
        
          "charge_date" => "charge_date-input",
        
      
        
          "created_at" => "created_at-input",
        
      
        
          "currency" => "currency-input",
        
      
        
          "description" => "description-input",
        
      
        
          "id" => "id-input",
        
      
        
        "links" => {
          
            "creditor" => "creditor-input",
          
            "mandate" => "mandate-input",
          
            "payout" => "payout-input",
          
            "subscription" => "subscription-input",
          
        },
        
      
        
          "metadata" => "metadata-input",
        
      
        
          "reference" => "reference-input",
        
      
        
          "status" => "status-input",
        
      
      }
    end

    it "can be initialized from an unenveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.amount).to eq("amount-input")
       
       
       
       expect(resource.amount_refunded).to eq("amount_refunded-input")
       
       
       
       expect(resource.charge_date).to eq("charge_date-input")
       
       
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.currency).to eq("currency-input")
       
       
       
       expect(resource.description).to eq("description-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
         
           expect(resource.links.creditor).to eq("creditor-input")
         
           expect(resource.links.mandate).to eq("mandate-input")
         
           expect(resource.links.payout).to eq("payout-input")
         
           expect(resource.links.subscription).to eq("subscription-input")
         
       
       
       
       expect(resource.metadata).to eq("metadata-input")
       
       
       
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
