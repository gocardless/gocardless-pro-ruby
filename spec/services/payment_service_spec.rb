require 'spec_helper'

describe GoCardless::Services::PaymentService do
  let(:client) do
    GoCardless::Client.new(
      user: "AK123",
      password: "ABC"
    )
  end

  
  
    

    
    describe "#create" do
    subject(:post_create_response) { client.payments.create(new_resource) }
      context "with a valid request" do
        let(:new_resource) do
          {
          
          "amount" => "amount-input",
          "amount_refunded" => "amount_refunded-input",
          "charge_date" => "charge_date-input",
          "created_at" => "created_at-input",
          "currency" => "currency-input",
          "description" => "description-input",
          "id" => "id-input",
          "links" => "links-input",
          "metadata" => "metadata-input",
          "reference" => "reference-input",
          "status" => "status-input",
          }
        end

        before do
          stub_request(:post, /.*api.gocardless.com\/payments/).to_return(
            body: {
              payments: {
                
                "amount" => "amount-input",
                "amount_refunded" => "amount_refunded-input",
                "charge_date" => "charge_date-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "description" => "description-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "reference" => "reference-input",
                "status" => "status-input",
                }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "creates and returns the resource" do
          expect(post_create_response).to be_a(GoCardless::Resources::Payment)
        end
      end

      context "with a request that returns a validation error" do
        let(:new_resource) { {} }

        before do
          stub_request(:post, /.*api.gocardless.com\/payments/).to_return(
            body: {
              error: {
                type: 'validation_failed',
                code: 422,
                errors: [
                  { message: 'test error message', field: 'test_field' }
                ]
              }
            }.to_json,
            headers: {'Content-Type' => 'application/json'},
            status: 422
          )
        end

        it "throws the correct error" do
          expect { post_create_response }.to raise_error(GoCardless::ValidationError)
        end
      end
    end
    
  
    

    
    describe "#list" do
      describe "with no filters" do
        subject(:get_list_response) { client.payments.list }

        before do
          stub_request(:get, /.*api.gocardless.com\/payments/).to_return(
            body: {
              payments: [{
                
                "amount" => "amount-input",
                "amount_refunded" => "amount_refunded-input",
                "charge_date" => "charge_date-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "description" => "description-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
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
          expect(get_list_response.map { |x| x.class }.uniq.first).to eq(GoCardless::Resources::Payment)

          
          
          expect(get_list_response.first.amount).to eq("amount-input")
          
          
          
          expect(get_list_response.first.amount_refunded).to eq("amount_refunded-input")
          
          
          
          expect(get_list_response.first.charge_date).to eq("charge_date-input")
          
          
          
          expect(get_list_response.first.created_at).to eq("created_at-input")
          
          
          
          expect(get_list_response.first.currency).to eq("currency-input")
          
          
          
          expect(get_list_response.first.description).to eq("description-input")
          
          
          
          expect(get_list_response.first.id).to eq("id-input")
          
          
          
          
          
          expect(get_list_response.first.metadata).to eq("metadata-input")
          
          
          
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
        stub_request(:get, /.*api.gocardless.com\/payments$/).to_return(
          body: {
            payments: [{
              
              "amount" => "amount-input",
              "amount_refunded" => "amount_refunded-input",
              "charge_date" => "charge_date-input",
              "created_at" => "created_at-input",
              "currency" => "currency-input",
              "description" => "description-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
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
        stub_request(:get, /.*api.gocardless.com\/payments\?after=AB345/).to_return(
          body: {
            payments: [{
              
              "amount" => "amount-input",
              "amount_refunded" => "amount_refunded-input",
              "charge_date" => "charge_date-input",
              "created_at" => "created_at-input",
              "currency" => "currency-input",
              "description" => "description-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
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
        expect(client.payments.all.to_a.length).to eq(2)
        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested
      end
    end

    
  
    

    
    describe "#get" do
      let(:id) { "ID123" }

      subject(:get_response) { client.payments.get(id) }

      context "when there is a payment to return" do
        before do
          stub_request(:get, /.*api.gocardless.com\/payments\/ID123/).to_return(
            body: {
              payments: {
                
                "amount" => "amount-input",
                "amount_refunded" => "amount_refunded-input",
                "charge_date" => "charge_date-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "description" => "description-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "reference" => "reference-input",
                "status" => "status-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "wraps the response in a resource" do
          expect(get_response).to be_a(GoCardless::Resources::Payment)
        end
      end
    end

    
  
    

    
    describe "#update" do
      subject(:put_update_response) { client.payments.update(id, update_params) }
      let(:id) { "ABC123" }

      context "with a valid request" do
        let(:update_params) { { "hello" => "world" } }

        let!(:stub) do
          stub_request(:put, /.*api.gocardless.com\/payments\/ABC123/).to_return(
            body: {
              payments: {
                
                "amount" => "amount-input",
                "amount_refunded" => "amount_refunded-input",
                "charge_date" => "charge_date-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "description" => "description-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "reference" => "reference-input",
                "status" => "status-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "updates and returns the resource" do
          expect(put_update_response).to be_a(GoCardless::Resources::Payment)
          expect(stub).to have_been_requested
        end
      end
    end
    
  
    

    
    describe "#cancel" do
      
      
        subject(:post_response) { client.payments.cancel(resource_id) }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /payments/%v/actions/cancel
        stub_url = "/payments/:identity/actions/cancel".gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            payments: {
              
              "amount" => "amount-input",
              "amount_refunded" => "amount_refunded-input",
              "charge_date" => "charge_date-input",
              "created_at" => "created_at-input",
              "currency" => "currency-input",
              "description" => "description-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
              "reference" => "reference-input",
              "status" => "status-input",
            }
          }.to_json,
          headers: {'Content-Type' => 'application/json'},
        )
      end

      it "wraps the response and calls the right endpoint" do
        expect(post_response).to be_a(GoCardless::Resources::Payment)

        expect(stub).to have_been_requested
      end
    end
    
  
    

    
    describe "#retry" do
      
      
        subject(:post_response) { client.payments.retry(resource_id) }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /payments/%v/actions/retry
        stub_url = "/payments/:identity/actions/retry".gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            payments: {
              
              "amount" => "amount-input",
              "amount_refunded" => "amount_refunded-input",
              "charge_date" => "charge_date-input",
              "created_at" => "created_at-input",
              "currency" => "currency-input",
              "description" => "description-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
              "reference" => "reference-input",
              "status" => "status-input",
            }
          }.to_json,
          headers: {'Content-Type' => 'application/json'},
        )
      end

      it "wraps the response and calls the right endpoint" do
        expect(post_response).to be_a(GoCardless::Resources::Payment)

        expect(stub).to have_been_requested
      end
    end
    
  
end
