require 'spec_helper'

describe GoCardlessPro::Services::RedirectFlowsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: "SECRET_TOKEN"
    )
  end

  
  
  
    

    
    describe "#create" do
    subject(:post_create_response) { client.redirect_flows.create(params: new_resource) }
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
          stub_request(:post, %r(.*api.gocardless.com/redirect_flows)).
          with(
            body: {
              "redirect_flows" => {
                
                "created_at" => "created_at-input",
                "description" => "description-input",
                "id" => "id-input",
                "links" => "links-input",
                "redirect_url" => "redirect_url-input",
                "scheme" => "scheme-input",
                "session_token" => "session_token-input",
                "success_redirect_url" => "success_redirect_url-input",
                }
            }
          ).
          to_return(
            body: {
              "redirect_flows" => {
                
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
          expect(post_create_response).to be_a(GoCardlessPro::Resources::RedirectFlow)
        end
      end

      context "with a request that returns a validation error" do
        let(:new_resource) { {} }

        before do
          stub_request(:post, %r(.*api.gocardless.com/redirect_flows)).to_return(
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
          expect { post_create_response }.to raise_error(GoCardlessPro::ValidationError)
        end
      end
    end
    
  
    

    
    describe "#get" do
      let(:id) { "ID123" }

      subject(:get_response) { client.redirect_flows.get(id) }

      context "passing in a custom header" do
        let!(:stub) do
          stub_url = "/redirect_flows/:identity".gsub(':identity', id)
          stub_request(:get, %r(.*api.gocardless.com#{stub_url})).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              "redirect_flows" => {
                
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

        subject(:get_response) do
          client.redirect_flows.get(id, headers: {
            'Foo' => 'Bar'
          })
        end

        it "includes the header" do
          get_response
          expect(stub).to have_been_requested
        end
      end

      context "when there is a redirect_flow to return" do
        before do
          stub_url = "/redirect_flows/:identity".gsub(':identity', id)
          stub_request(:get, %r(.*api.gocardless.com#{stub_url})).to_return(
            body: {
              "redirect_flows" => {
                
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
          expect(get_response).to be_a(GoCardlessPro::Resources::RedirectFlow)
        end
      end

      context "when nothing is returned" do
        before do
          stub_url = "/redirect_flows/:identity".gsub(':identity', id)
          stub_request(:get, %r(.*api.gocardless.com#{stub_url})).to_return(
            body: "",
            headers: { 'Content-Type' => 'application/json' }
          )
        end

        it "returns nil" do
          expect(get_response).to be_nil
        end
      end
    end

    
  
    

    
    describe "#complete" do
      
      
        subject(:post_response) { client.redirect_flows.complete(resource_id) }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /redirect_flows/%v/actions/complete
        stub_url = "/redirect_flows/:identity/actions/complete".gsub(':identity', resource_id)
        stub_request(:post, %r(.*api.gocardless.com#{stub_url})).to_return(
          body: {
            "redirect_flows" => {
              
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
        expect(post_response).to be_a(GoCardlessPro::Resources::RedirectFlow)

        expect(stub).to have_been_requested
      end

      context "when the request needs a body and custom header" do
        
          let(:body) { { foo: 'bar' } }
          let(:headers) { { 'Foo' => 'Bar' } }
          subject(:post_response) { client.redirect_flows.complete(resource_id, body, headers) }
        
        let(:resource_id) { "ABC123" }

        let!(:stub) do
          # /redirect_flows/%v/actions/complete
          stub_url = "/redirect_flows/:identity/actions/complete".gsub(':identity', resource_id)
          stub_request(:post, %r(.*api.gocardless.com#{stub_url})).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              "redirect_flows" => {
                
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
      end
    end
    
  
end
