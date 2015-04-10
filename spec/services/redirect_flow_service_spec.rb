require 'spec_helper'

describe GoCardless::Services::RedirectFlowService do
  let(:client) do
    GoCardless::Client.new(
      user: "AK123",
      password: "ABC"
    )
  end

  
  
    

    
    describe "#create" do
    subject(:post_create_response) { client.redirect_flows.create(new_resource) }
      context "with a valid request" do
        let(:new_resource) do
          {
          
          "created_at" => "created_at-input",
          "description" => "description-input",
          "id" => "id-input",
          "links" => "links-input",
          "redirect_url" => "redirect_url-input",
          "scheme" => "scheme-input",
          "session_token" => "session_token-input",
          "success_redirect_url" => "success_redirect_url-input",
          }
        end

        before do
          stub_request(:post, /.*api.gocardless.com\/redirect_flows/).to_return(
            body: {
              redirect_flows: {
                
                "created_at" => "created_at-input",
                "description" => "description-input",
                "id" => "id-input",
                "links" => "links-input",
                "redirect_url" => "redirect_url-input",
                "scheme" => "scheme-input",
                "session_token" => "session_token-input",
                "success_redirect_url" => "success_redirect_url-input",
                }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "creates and returns the resource" do
          expect(post_create_response).to be_a(GoCardless::Resources::RedirectFlow)
        end
      end

      context "with a request that returns a validation error" do
        let(:new_resource) { {} }

        before do
          stub_request(:post, /.*api.gocardless.com\/redirect_flows/).to_return(
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
    
  
    

    
    describe "#get" do
      let(:id) { "ID123" }

      subject(:get_response) { client.redirect_flows.get(id) }

      context "when there is a redirect_flow to return" do
        before do
          stub_request(:get, /.*api.gocardless.com\/redirect_flows\/ID123/).to_return(
            body: {
              redirect_flows: {
                
                "created_at" => "created_at-input",
                "description" => "description-input",
                "id" => "id-input",
                "links" => "links-input",
                "redirect_url" => "redirect_url-input",
                "scheme" => "scheme-input",
                "session_token" => "session_token-input",
                "success_redirect_url" => "success_redirect_url-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "wraps the response in a resource" do
          expect(get_response).to be_a(GoCardless::Resources::RedirectFlow)
        end
      end
    end

    
  
    

    
    describe "#complete" do
      
      
        subject(:post_response) { client.redirect_flows.complete(resource_id) }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /redirect_flows/%v/actions/complete
        stub_url = "/redirect_flows/:identity/actions/complete".gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            redirect_flows: {
              
              "created_at" => "created_at-input",
              "description" => "description-input",
              "id" => "id-input",
              "links" => "links-input",
              "redirect_url" => "redirect_url-input",
              "scheme" => "scheme-input",
              "session_token" => "session_token-input",
              "success_redirect_url" => "success_redirect_url-input",
            }
          }.to_json,
          headers: {'Content-Type' => 'application/json'},
        )
      end

      it "wraps the response and calls the right endpoint" do
        expect(post_response).to be_a(GoCardless::Resources::RedirectFlow)

        expect(stub).to have_been_requested
      end
    end
    
  
end
