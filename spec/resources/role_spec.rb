require 'spec_helper'

describe GoCardless::Resources::Role do
  describe "initialising" do
    let(:data) do
      {
      
        
          "created_at" => "created_at-input",
        
      
        
          "enabled" => "enabled-input",
        
      
        
          "id" => "id-input",
        
      
        
          "name" => "name-input",
        
      
        
          "permissions" => "permissions-input",
        
      
      }
    end

    it "can be initialized from an uneveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.enabled).to eq("enabled-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
       expect(resource.name).to eq("name-input")
       
       
       
       expect(resource.permissions).to eq("permissions-input")
       
       
    end
  end
end

