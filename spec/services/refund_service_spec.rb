require 'spec_helper'

describe GoCardless::Services::RefundService do
  let(:client) do
    GoCardless::Client.new(
      user: "AK123",
      password: "ABC"
    )
  end

  
  
    

    
    describe "#create" do
    subject(:post_create_response) { client.refunds.create(new_resource) }
      context "with a valid request" do
        let(:new_resource) do
          {
          
          "amount" => "amount-input",
          "created_at" => "created_at-input",
          "currency" => "currency-input",
          "id" => "id-input",
          "links" => "links-input",
          "metadata" => "metadata-input",
          }
        end

        before do
          stub_request(:post, /.*api.gocardless.com\/refunds/).to_return(
            body: {
              refunds: {
                
                "amount" => "amount-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "creates and returns the resource" do
          expect(post_create_response).to be_a(GoCardless::Resources::Refund)
        end
      end

      context "with a request that returns a validation error" do
        let(:new_resource) { {} }

        before do
          stub_request(:post, /.*api.gocardless.com\/refunds/).to_return(
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
        subject(:get_list_response) { client.refunds.list }

        before do
          stub_request(:get, /.*api.gocardless.com\/refunds/).to_return(
            body: {
              refunds: [{
                
                "amount" => "amount-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
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
          expect(get_list_response.map { |x| x.class }.uniq.first).to eq(GoCardless::Resources::Refund)

          
          
          expect(get_list_response.first.amount).to eq("amount-input")
          
          
          
          expect(get_list_response.first.created_at).to eq("created_at-input")
          
          
          
          expect(get_list_response.first.currency).to eq("currency-input")
          
          
          
          expect(get_list_response.first.id).to eq("id-input")
          
          
          
          
          
          expect(get_list_response.first.metadata).to eq("metadata-input")
          
          
        end

        it "exposes the cursors for before and after" do
          expect(get_list_response.before).to eq(nil)
          expect(get_list_response.after).to eq("ABC123")
        end
      end
    end

    describe "#all" do
      let!(:first_response_stub) do
        stub_request(:get, /.*api.gocardless.com\/refunds$/).to_return(
          body: {
            refunds: [{
              
              "amount" => "amount-input",
              "created_at" => "created_at-input",
              "currency" => "currency-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
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
        stub_request(:get, /.*api.gocardless.com\/refunds\?after=AB345/).to_return(
          body: {
            refunds: [{
              
              "amount" => "amount-input",
              "created_at" => "created_at-input",
              "currency" => "currency-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
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
        expect(client.refunds.all.to_a.length).to eq(2)
        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested
      end
    end

    
  
    

    
    describe "#get" do
      let(:id) { "ID123" }

      subject(:get_response) { client.refunds.get(id) }

      context "when there is a refund to return" do
        before do
          stub_request(:get, /.*api.gocardless.com\/refunds\/ID123/).to_return(
            body: {
              refunds: {
                
                "amount" => "amount-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "wraps the response in a resource" do
          expect(get_response).to be_a(GoCardless::Resources::Refund)
        end
      end
    end

    
  
    

    
    describe "#update" do
      subject(:put_update_response) { client.refunds.update(id, update_params) }
      let(:id) { "ABC123" }

      context "with a valid request" do
        let(:update_params) { { "hello" => "world" } }

        let!(:stub) do
          stub_request(:put, /.*api.gocardless.com\/refunds\/ABC123/).to_return(
            body: {
              refunds: {
                
                "amount" => "amount-input",
                "created_at" => "created_at-input",
                "currency" => "currency-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "updates and returns the resource" do
          expect(put_update_response).to be_a(GoCardless::Resources::Refund)
          expect(stub).to have_been_requested
        end
      end
    end
    
  
end
