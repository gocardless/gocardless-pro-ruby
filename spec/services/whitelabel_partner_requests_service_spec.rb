require 'spec_helper'

describe GoCardlessPro::Services::WhitelabelPartnerRequestsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: "SECRET_TOKEN"
    )
  end

  
  
  
    

    
    describe "#create" do
    subject(:post_create_response) { client.whitelabel_partner_requests.create(params: new_resource) }
      context "with a valid request" do
        let(:new_resource) do
          {
          
          }
        end

        before do
          stub_request(:post, %r(.*api.gocardless.com/whitelabel_partner_requests)).
          with(
            body: {
              "whitelabel_partner_requests" => {
                
                }
            }
          ).
          to_return(
            body: {
              "whitelabel_partner_requests" => {
                
                }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "creates and returns the resource" do
          expect(post_create_response).to be_a(GoCardlessPro::Resources::WhitelabelPartnerRequest)
        end
      end

      context "with a request that returns a validation error" do
        let(:new_resource) { {} }

        before do
          stub_request(:post, %r(.*api.gocardless.com/whitelabel_partner_requests)).to_return(
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
    
  
end
