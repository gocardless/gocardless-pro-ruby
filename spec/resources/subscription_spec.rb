require 'spec_helper'

describe GoCardlessPro::Resources::Subscription do
  describe "initialising" do
    let(:data) do
      {
      
        
          "amount" => "amount-input",
        
      
        
          "count" => "count-input",
        
      
        
          "created_at" => "created_at-input",
        
      
        
          "currency" => "currency-input",
        
      
        
          "day_of_month" => "day_of_month-input",
        
      
        
          "end_date" => "end_date-input",
        
      
        
          "id" => "id-input",
        
      
        
          "interval" => "interval-input",
        
      
        
          "interval_unit" => "interval_unit-input",
        
      
        
        "links" => {
          
            "mandate" => "mandate-input",
          
        },
        
      
        
          "metadata" => "metadata-input",
        
      
        
          "month" => "month-input",
        
      
        
          "name" => "name-input",
        
      
        
          "payment_reference" => "payment_reference-input",
        
      
        
          "start_date" => "start_date-input",
        
      
        
          "status" => "status-input",
        
      
        
          "upcoming_payments" => "upcoming_payments-input",
        
      
      }
    end

    it "can be initialized from an unenveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.amount).to eq("amount-input")
       
       
       
       expect(resource.count).to eq("count-input")
       
       
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.currency).to eq("currency-input")
       
       
       
       expect(resource.day_of_month).to eq("day_of_month-input")
       
       
       
       expect(resource.end_date).to eq("end_date-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
       expect(resource.interval).to eq("interval-input")
       
       
       
       expect(resource.interval_unit).to eq("interval_unit-input")
       
       
       
         
           expect(resource.links.mandate).to eq("mandate-input")
         
       
       
       
       expect(resource.metadata).to eq("metadata-input")
       
       
       
       expect(resource.month).to eq("month-input")
       
       
       
       expect(resource.name).to eq("name-input")
       
       
       
       expect(resource.payment_reference).to eq("payment_reference-input")
       
       
       
       expect(resource.start_date).to eq("start_date-input")
       
       
       
       expect(resource.status).to eq("status-input")
       
       
       
       expect(resource.upcoming_payments).to eq("upcoming_payments-input")
       
       
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
