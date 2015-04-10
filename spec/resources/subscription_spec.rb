require 'spec_helper'

describe GoCardless::Resources::Subscription do
  describe "initialising" do
    let(:data) do
      {
      
        
          "amount" => "amount-input",
        
      
        
          "count" => "count-input",
        
      
        
          "created_at" => "created_at-input",
        
      
        
          "currency" => "currency-input",
        
      
        
          "day_of_month" => "day_of_month-input",
        
      
        
          "end_at" => "end_at-input",
        
      
        
          "id" => "id-input",
        
      
        
          "interval" => "interval-input",
        
      
        
          "interval_unit" => "interval_unit-input",
        
      
        
        "links" => {
          
            "mandate" => "mandate-input",
          
        },
        
      
        
          "metadata" => "metadata-input",
        
      
        
          "month" => "month-input",
        
      
        
          "name" => "name-input",
        
      
        
          "start_at" => "start_at-input",
        
      
        
          "status" => "status-input",
        
      
        
          "upcoming_payments" => "upcoming_payments-input",
        
      
      }
    end

    it "can be initialized from an uneveloped response" do
      resource = described_class.new(data)
      
       
       expect(resource.amount).to eq("amount-input")
       
       
       
       expect(resource.count).to eq("count-input")
       
       
       
       expect(resource.created_at).to eq("created_at-input")
       
       
       
       expect(resource.currency).to eq("currency-input")
       
       
       
       expect(resource.day_of_month).to eq("day_of_month-input")
       
       
       
       expect(resource.end_at).to eq("end_at-input")
       
       
       
       expect(resource.id).to eq("id-input")
       
       
       
       expect(resource.interval).to eq("interval-input")
       
       
       
       expect(resource.interval_unit).to eq("interval_unit-input")
       
       
       
         
           expect(resource.links.mandate).to eq("mandate-input")
         
       
       
       
       expect(resource.metadata).to eq("metadata-input")
       
       
       
       expect(resource.month).to eq("month-input")
       
       
       
       expect(resource.name).to eq("name-input")
       
       
       
       expect(resource.start_at).to eq("start_at-input")
       
       
       
       expect(resource.status).to eq("status-input")
       
       
       
       expect(resource.upcoming_payments).to eq("upcoming_payments-input")
       
       
    end
  end
end

