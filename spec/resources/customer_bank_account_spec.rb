require 'spec_helper'

describe GoCardlessPro::Resources::CustomerBankAccount do
  describe "initialising" do
    let(:data) do
      {
      
        
          "account_holder_name" => "account_holder_name-input",
        
      
        
          "account_number_ending" => "account_number_ending-input",
        
      
        
          "bank_name" => "bank_name-input",
        
      
        
          "country_code" => "country_code-input",
        
      
        
          "created_at" => "created_at-input",
        
      
        
          "currency" => "currency-input",
        
      
        
          "enabled" => "enabled-input",
        
      
        
          "id" => "id-input",
        
      
        
        "links" => {
          
            "customer" => "customer-input",
          
        },
        
      
        
          "metadata" => "metadata-input",
        
      
      }
    end

    it "can be initialized from an unenveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.account_holder_name).to eq("account_holder_name-input")
       
       
       
       expect(resource.account_number_ending).to eq("account_number_ending-input")
       
       
       
       expect(resource.bank_name).to eq("bank_name-input")
       
       
       
       expect(resource.country_code).to eq("country_code-input")
       
       
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.currency).to eq("currency-input")
       
       
       
       expect(resource.enabled).to eq("enabled-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
         
           expect(resource.links.customer).to eq("customer-input")
         
       
       
       
       expect(resource.metadata).to eq("metadata-input")
       
       
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
