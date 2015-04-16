require 'spec_helper'

describe GoCardless::Resources::User do
  describe "initialising" do
    let(:data) do
      {
      
        
          "created_at" => "created_at-input",
        
      
        
          "email" => "email-input",
        
      
        
          "enabled" => "enabled-input",
        
      
        
          "family_name" => "family_name-input",
        
      
        
          "given_name" => "given_name-input",
        
      
        
          "id" => "id-input",
        
      
        
        "links" => {
          
            "role" => "role-input",
          
        },
        
      
      }
    end

    it "can be initialized from an uneveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.email).to eq("email-input")
       
       
       
       expect(resource.enabled).to eq("enabled-input")
       
       
       
       expect(resource.family_name).to eq("family_name-input")
       
       
       
       expect(resource.given_name).to eq("given_name-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
         
           expect(resource.links.role).to eq("role-input")
         
       
       
    end
  end
end

