require 'spec_helper'

describe GoCardlessPro::Resources::Event do
  describe "initialising" do
    let(:data) do
      {
      
        
          "action" => "action-input",
        
      
        
          "created_at" => "created_at-input",
        
      
        
          "details" => "details-input",
        
      
        
          "id" => "id-input",
        
      
        
        "links" => {
          
            "mandate" => "mandate-input",
          
            "new_customer_bank_account" => "new_customer_bank_account-input",
          
            "organisation" => "organisation-input",
          
            "parent_event" => "parent_event-input",
          
            "payment" => "payment-input",
          
            "payout" => "payout-input",
          
            "previous_customer_bank_account" => "previous_customer_bank_account-input",
          
            "refund" => "refund-input",
          
            "subscription" => "subscription-input",
          
        },
        
      
        
          "metadata" => "metadata-input",
        
      
        
          "resource_type" => "resource_type-input",
        
      
      }
    end

    it "can be initialized from an unenveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.action).to eq("action-input")
       
       
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.details).to eq("details-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
         
           expect(resource.links.mandate).to eq("mandate-input")
         
           expect(resource.links.new_customer_bank_account).to eq("new_customer_bank_account-input")
         
           expect(resource.links.organisation).to eq("organisation-input")
         
           expect(resource.links.parent_event).to eq("parent_event-input")
         
           expect(resource.links.payment).to eq("payment-input")
         
           expect(resource.links.payout).to eq("payout-input")
         
           expect(resource.links.previous_customer_bank_account).to eq("previous_customer_bank_account-input")
         
           expect(resource.links.refund).to eq("refund-input")
         
           expect(resource.links.subscription).to eq("subscription-input")
         
       
       
       
       expect(resource.metadata).to eq("metadata-input")
       
       
       
       expect(resource.resource_type).to eq("resource_type-input")
       
       
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
