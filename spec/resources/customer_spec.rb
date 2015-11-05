require 'spec_helper'

describe GoCardlessPro::Resources::Customer do
  describe "initialising" do
    let(:data) do
      {
      
        
          "address_line1" => "address_line1-input",
        
      
        
          "address_line2" => "address_line2-input",
        
      
        
          "address_line3" => "address_line3-input",
        
      
        
          "city" => "city-input",
        
      
        
          "company_name" => "company_name-input",
        
      
        
          "country_code" => "country_code-input",
        
      
        
          "created_at" => "created_at-input",
        
      
        
          "email" => "email-input",
        
      
        
          "family_name" => "family_name-input",
        
      
        
          "given_name" => "given_name-input",
        
      
        
          "id" => "id-input",
        
      
        
          "language" => "language-input",
        
      
        
          "metadata" => "metadata-input",
        
      
        
          "postal_code" => "postal_code-input",
        
      
        
          "region" => "region-input",
        
      
        
          "swedish_identity_number" => "swedish_identity_number-input",
        
      
      }
    end

    it "can be initialized from an unenveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.address_line1).to eq("address_line1-input")
       
       
       
       expect(resource.address_line2).to eq("address_line2-input")
       
       
       
       expect(resource.address_line3).to eq("address_line3-input")
       
       
       
       expect(resource.city).to eq("city-input")
       
       
       
       expect(resource.company_name).to eq("company_name-input")
       
       
       
       expect(resource.country_code).to eq("country_code-input")
       
       
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.email).to eq("email-input")
       
       
       
       expect(resource.family_name).to eq("family_name-input")
       
       
       
       expect(resource.given_name).to eq("given_name-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
       expect(resource.language).to eq("language-input")
       
       
       
       expect(resource.metadata).to eq("metadata-input")
       
       
       
       expect(resource.postal_code).to eq("postal_code-input")
       
       
       
       expect(resource.region).to eq("region-input")
       
       
       
       expect(resource.swedish_identity_number).to eq("swedish_identity_number-input")
       
       
    end

    it "can handle new attributes without erroring" do
      data["foo"] = "bar"
      expect { described_class.new(data) }.to_not raise_error
    end

    

    describe "#to_h" do
      it "returns a hash representing the resource" do
        expect(described_class.new(data).to_h).to eq(data)
      end
    end
  end
end
