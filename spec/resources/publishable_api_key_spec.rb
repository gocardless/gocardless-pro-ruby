require 'spec_helper'

describe GoCardless::Resources::PublishableApiKey do
  describe "initialising" do
    let(:data) do
      {
      
        
          "created_at" => "created_at-input",
        
      
        
          "enabled" => "enabled-input",
        
      
        
          "id" => "id-input",
        
      
        
          "key" => "key-input",
        
      
        
          "name" => "name-input",
        
      
      }
    end

    it "can be initialized from an uneveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.enabled).to eq("enabled-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
       expect(resource.key).to eq("key-input")
       
       
       
       expect(resource.name).to eq("name-input")
       
       
    end
  end
end

