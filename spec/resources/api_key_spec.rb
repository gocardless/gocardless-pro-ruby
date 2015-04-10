require 'spec_helper'

describe GoCardless::Resources::ApiKey do
  describe "initialising" do
    let(:data) do
      {
      
        
          "created_at" => "created_at-input",
        
      
        
          "enabled" => "enabled-input",
        
      
        
          "id" => "id-input",
        
      
        
          "key" => "key-input",
        
      
        
        "links" => {
          
            "role" => "role-input",
          
        },
        
      
        
          "name" => "name-input",
        
      
        
          "webhook_url" => "webhook_url-input",
        
      
      }
    end

    it "can be initialized from an uneveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.enabled).to eq("enabled-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
       expect(resource.key).to eq("key-input")
       
       
       
         
           expect(resource.links.role).to eq("role-input")
         
       
       
       
       expect(resource.name).to eq("name-input")
       
       
       
       expect(resource.webhook_url).to eq("webhook_url-input")
       
       
    end
  end
end

