require 'spec_helper'

describe GoCardlessPro::Services::HelpersService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: "SECRET_TOKEN"
    )
  end

  
  
    

    
    describe "#mandate" do
      
      
        subject(:post_response) { client.helpers.mandate }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /helpers/mandate
        stub_url = "/helpers/mandate".gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            helpers: {
              
            }
          }.to_json,
          headers: {'Content-Type' => 'application/json'},
        )
      end

      it "wraps the response and calls the right endpoint" do
        expect(post_response).to be_a(GoCardlessPro::Resources::Helper)

        expect(stub).to have_been_requested
      end

      context "when the request needs a body and custom header" do
        
          subject(:post_response) { client.helpers.mandate(body, headers) }
        
        let(:resource_id) { "ABC123" }

        let!(:stub) do
          # /helpers/mandate
          stub_url = "/helpers/mandate".gsub(':identity', resource_id)
          stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              helpers: {
                
              }
            }.to_json,
            headers: {'Content-Type' => 'application/json'},
          )
        end
      end
    end
    
  
    

    
    describe "#modulus_check" do
      
      
        subject(:post_response) { client.helpers.modulus_check }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /helpers/modulus_check
        stub_url = "/helpers/modulus_check".gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            helpers: {
              
            }
          }.to_json,
          headers: {'Content-Type' => 'application/json'},
        )
      end

      it "wraps the response and calls the right endpoint" do
        expect(post_response).to be_a(GoCardlessPro::Resources::Helper)

        expect(stub).to have_been_requested
      end

      context "when the request needs a body and custom header" do
        
          subject(:post_response) { client.helpers.modulus_check(body, headers) }
        
        let(:resource_id) { "ABC123" }

        let!(:stub) do
          # /helpers/modulus_check
          stub_url = "/helpers/modulus_check".gsub(':identity', resource_id)
          stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              helpers: {
                
              }
            }.to_json,
            headers: {'Content-Type' => 'application/json'},
          )
        end
      end
    end
    
  
end
