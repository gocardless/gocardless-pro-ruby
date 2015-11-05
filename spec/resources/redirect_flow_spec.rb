require 'spec_helper'

describe GoCardlessPro::Resources::RedirectFlow do
  describe "initialising" do
    let(:data) do
      {
      
        
          "created_at" => "created_at-input",
        
      
        
          "description" => "description-input",
        
      
        
          "id" => "id-input",
        
      
        
        "links" => {
          
            "creditor" => "creditor-input",
          
            "customer" => "customer-input",
          
            "customer_bank_account" => "customer_bank_account-input",
          
            "mandate" => "mandate-input",
          
        },
        
      
        
          "redirect_url" => "redirect_url-input",
        
      
        
          "scheme" => "scheme-input",
        
      
        
          "session_token" => "session_token-input",
        
      
        
          "success_redirect_url" => "success_redirect_url-input",
        
      
      }
    end

    it "can be initialized from an unenveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.description).to eq("description-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
         
           expect(resource.links.creditor).to eq("creditor-input")
         
           expect(resource.links.customer).to eq("customer-input")
         
           expect(resource.links.customer_bank_account).to eq("customer_bank_account-input")
         
           expect(resource.links.mandate).to eq("mandate-input")
         
       
       
       
       expect(resource.redirect_url).to eq("redirect_url-input")
       
       
       
       expect(resource.scheme).to eq("scheme-input")
       
       
       
       expect(resource.session_token).to eq("session_token-input")
       
       
       
       expect(resource.success_redirect_url).to eq("success_redirect_url-input")
       
       
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
