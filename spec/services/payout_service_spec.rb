require 'spec_helper'

describe GoCardless::Services::PayoutService do
  let(:client) do
    GoCardless::Client.new(
      user: "AK123",
      password: "ABC"
    )
  end

  
  
    

    
    describe "#list" do
      describe "with no filters" do
        subject(:get_list_response) { client.payouts.list }

        before do
          stub_request(:get, /.*api.gocardless.com\/payouts/).to_return(
            body: {
              payouts: [{
                
                "amount" => "amount-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "id" => "id-input",
                "links" => "links-input",
                "reference" => "reference-input",
                "status" => "status-input",
                }],
                meta: {
                  cursors: {
                    before: nil,
                    after: "ABC123"
                  }
                }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "wraps each item in the resource class" do
          expect(get_list_response.map { |x| x.class }.uniq.first).to eq(GoCardless::Resources::Payout)

          
          
          expect(get_list_response.first.amount).to eq("amount-input")
          
          
          
          expect(get_list_response.first.created_at).to eq("created_at-input")
          
          
          
          expect(get_list_response.first.currency).to eq("currency-input")
          
          
          
          expect(get_list_response.first.id).to eq("id-input")
          
          
          
          
          
          expect(get_list_response.first.reference).to eq("reference-input")
          
          
          
          expect(get_list_response.first.status).to eq("status-input")
          
          
        end

        it "exposes the cursors for before and after" do
          expect(get_list_response.before).to eq(nil)
          expect(get_list_response.after).to eq("ABC123")
        end
      end
    end

    describe "#all" do
      let!(:first_response_stub) do
        stub_request(:get, /.*api.gocardless.com\/payouts$/).to_return(
          body: {
            payouts: [{
              
              "amount" => "amount-input",
              "created_at" => "created_at-input",
              "currency" => "currency-input",
              "id" => "id-input",
              "links" => "links-input",
              "reference" => "reference-input",
              "status" => "status-input",
            }],
            meta: {
              cursors: { after: 'AB345' },
              limit: 1
            }
          }.to_json,
          :headers => {'Content-Type' => 'application/json'}
        )
      end

      let!(:second_response_stub) do
        stub_request(:get, /.*api.gocardless.com\/payouts\?after=AB345/).to_return(
          body: {
            payouts: [{
              
              "amount" => "amount-input",
              "created_at" => "created_at-input",
              "currency" => "currency-input",
              "id" => "id-input",
              "links" => "links-input",
              "reference" => "reference-input",
              "status" => "status-input",
            }],
            meta: {
              limit: 2,
              cursors: {}
            }
          }.to_json,
          :headers => {'Content-Type' => 'application/json'}
        )
      end

      it "automatically makes the extra requests" do
        expect(client.payouts.all.to_a.length).to eq(2)
        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested
      end
    end

    
  
    

    
    describe "#get" do
      let(:id) { "ID123" }

      subject(:get_response) { client.payouts.get(id) }

      context "when there is a payout to return" do
        before do
          stub_request(:get, /.*api.gocardless.com\/payouts\/ID123/).to_return(
            body: {
              payouts: {
                
                "amount" => "amount-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "id" => "id-input",
                "links" => "links-input",
                "reference" => "reference-input",
                "status" => "status-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "wraps the response in a resource" do
          expect(get_response).to be_a(GoCardless::Resources::Payout)
        end
      end
    end

    
  
end
