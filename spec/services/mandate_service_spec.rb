require 'spec_helper'

describe GoCardless::Services::MandateService do
  let(:client) do
    GoCardless::Client.new(
      user: "AK123",
      password: "ABC"
    )
  end

  
  
    

    
    describe "#create" do
    subject(:post_create_response) { client.mandates.create(new_resource) }
      context "with a valid request" do
        let(:new_resource) do
          {
          
          "created_at" => "created_at-input",
          "id" => "id-input",
          "links" => "links-input",
          "metadata" => "metadata-input",
          "next_possible_charge_date" => "next_possible_charge_date-input",
          "reference" => "reference-input",
          "scheme" => "scheme-input",
          "status" => "status-input",
          }
        end

        before do
          stub_request(:post, /.*api.gocardless.com\/mandates/).
          with(
            body: {
              mandates: {
                
                "created_at" => "created_at-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "next_possible_charge_date" => "next_possible_charge_date-input",
                "reference" => "reference-input",
                "scheme" => "scheme-input",
                "status" => "status-input",
                }
            }
          ).
          to_return(
            body: {
              mandates: {
                
                "created_at" => "created_at-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "next_possible_charge_date" => "next_possible_charge_date-input",
                "reference" => "reference-input",
                "scheme" => "scheme-input",
                "status" => "status-input",
                }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "creates and returns the resource" do
          expect(post_create_response).to be_a(GoCardless::Resources::Mandate)
        end
      end

      context "with a request that returns a validation error" do
        let(:new_resource) { {} }

        before do
          stub_request(:post, /.*api.gocardless.com\/mandates/).to_return(
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
        subject(:get_list_response) { client.mandates.list }

        before do
          stub_request(:get, /.*api.gocardless.com\/mandates/).to_return(
            body: {
              mandates: [{
                
                "created_at" => "created_at-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "next_possible_charge_date" => "next_possible_charge_date-input",
                "reference" => "reference-input",
                "scheme" => "scheme-input",
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
          expect(get_list_response.map { |x| x.class }.uniq.first).to eq(GoCardless::Resources::Mandate)

          
          
          expect(get_list_response.first.created_at).to eq("created_at-input")
          
          
          
          expect(get_list_response.first.id).to eq("id-input")
          
          
          
          
          
          expect(get_list_response.first.metadata).to eq("metadata-input")
          
          
          
          expect(get_list_response.first.next_possible_charge_date).to eq("next_possible_charge_date-input")
          
          
          
          expect(get_list_response.first.reference).to eq("reference-input")
          
          
          
          expect(get_list_response.first.scheme).to eq("scheme-input")
          
          
          
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
        stub_request(:get, /.*api.gocardless.com\/mandates$/).to_return(
          body: {
            mandates: [{
              
              "created_at" => "created_at-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
              "next_possible_charge_date" => "next_possible_charge_date-input",
              "reference" => "reference-input",
              "scheme" => "scheme-input",
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
        stub_request(:get, /.*api.gocardless.com\/mandates\?after=AB345/).to_return(
          body: {
            mandates: [{
              
              "created_at" => "created_at-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
              "next_possible_charge_date" => "next_possible_charge_date-input",
              "reference" => "reference-input",
              "scheme" => "scheme-input",
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
        expect(client.mandates.all.to_a.length).to eq(2)
        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested
      end
    end

    
  
    

    
    describe "#get" do
      let(:id) { "ID123" }

      subject(:get_response) { client.mandates.get(id) }

      context "when there is a mandate to return" do
        before do
          stub_request(:get, /.*api.gocardless.com\/mandates\/ID123/).to_return(
            body: {
              mandates: {
                
                "created_at" => "created_at-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "next_possible_charge_date" => "next_possible_charge_date-input",
                "reference" => "reference-input",
                "scheme" => "scheme-input",
                "status" => "status-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "wraps the response in a resource" do
          expect(get_response).to be_a(GoCardless::Resources::Mandate)
        end
      end
    end

    
  
    

    
    describe "#update" do
      subject(:put_update_response) { client.mandates.update(id, update_params) }
      let(:id) { "ABC123" }

      context "with a valid request" do
        let(:update_params) { { "hello" => "world" } }

        let!(:stub) do
          stub_request(:put, /.*api.gocardless.com\/mandates\/ABC123/).to_return(
            body: {
              mandates: {
                
                "created_at" => "created_at-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "next_possible_charge_date" => "next_possible_charge_date-input",
                "reference" => "reference-input",
                "scheme" => "scheme-input",
                "status" => "status-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "updates and returns the resource" do
          expect(put_update_response).to be_a(GoCardless::Resources::Mandate)
          expect(stub).to have_been_requested
        end
      end
    end
    
  
    

    
    describe "#cancel" do
      
      
        subject(:post_response) { client.mandates.cancel(resource_id) }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /mandates/%v/actions/cancel
        stub_url = "/mandates/:identity/actions/cancel".gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            mandates: {
              
              "created_at" => "created_at-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
              "next_possible_charge_date" => "next_possible_charge_date-input",
              "reference" => "reference-input",
              "scheme" => "scheme-input",
              "status" => "status-input",
            }
          }.to_json,
          headers: {'Content-Type' => 'application/json'},
        )
      end

      it "wraps the response and calls the right endpoint" do
        expect(post_response).to be_a(GoCardless::Resources::Mandate)

        expect(stub).to have_been_requested
      end
    end
    
  
    

    
    describe "#reinstate" do
      
      
        subject(:post_response) { client.mandates.reinstate(resource_id) }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /mandates/%v/actions/reinstate
        stub_url = "/mandates/:identity/actions/reinstate".gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            mandates: {
              
              "created_at" => "created_at-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
              "next_possible_charge_date" => "next_possible_charge_date-input",
              "reference" => "reference-input",
              "scheme" => "scheme-input",
              "status" => "status-input",
            }
          }.to_json,
          headers: {'Content-Type' => 'application/json'},
        )
      end

      it "wraps the response and calls the right endpoint" do
        expect(post_response).to be_a(GoCardless::Resources::Mandate)

        expect(stub).to have_been_requested
      end
    end
    
  
end
