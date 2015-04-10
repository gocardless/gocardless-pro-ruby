require 'spec_helper'

describe GoCardless::Services::UserService do
  let(:client) do
    GoCardless::Client.new(
      api_key: "AK123",
      api_secret: "ABC"
    )
  end

  
  
    

    
    describe "#create" do
    subject(:post_create_response) { client.users.create(new_resource) }
      context "with a valid request" do
        let(:new_resource) do
          {
          
          "created_at" => "created_at-input",
          "email" => "email-input",
          "enabled" => "enabled-input",
          "family_name" => "family_name-input",
          "given_name" => "given_name-input",
          "id" => "id-input",
          "links" => "links-input",
          }
        end

        before do
          stub_request(:post, /.*api.gocardless.com\/users/).
          with(
            body: {
              users: {
                
                "created_at" => "created_at-input",
                "email" => "email-input",
                "enabled" => "enabled-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "links" => "links-input",
                }
            }
          ).
          to_return(
            body: {
              users: {
                
                "created_at" => "created_at-input",
                "email" => "email-input",
                "enabled" => "enabled-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "links" => "links-input",
                }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "creates and returns the resource" do
          expect(post_create_response).to be_a(GoCardless::Resources::User)
        end
      end

      context "with a request that returns a validation error" do
        let(:new_resource) { {} }

        before do
          stub_request(:post, /.*api.gocardless.com\/users/).to_return(
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
        subject(:get_list_response) { client.users.list }

        before do
          stub_request(:get, /.*api.gocardless.com\/users/).to_return(
            body: {
              users: [{
                
                "created_at" => "created_at-input",
                "email" => "email-input",
                "enabled" => "enabled-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "links" => "links-input",
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
          expect(get_list_response.map { |x| x.class }.uniq.first).to eq(GoCardless::Resources::User)

          
          
          expect(get_list_response.first.created_at).to eq("created_at-input")
          
          
          
          expect(get_list_response.first.email).to eq("email-input")
          
          
          
          expect(get_list_response.first.enabled).to eq("enabled-input")
          
          
          
          expect(get_list_response.first.family_name).to eq("family_name-input")
          
          
          
          expect(get_list_response.first.given_name).to eq("given_name-input")
          
          
          
          expect(get_list_response.first.id).to eq("id-input")
          
          
          
          
        end

        it "exposes the cursors for before and after" do
          expect(get_list_response.before).to eq(nil)
          expect(get_list_response.after).to eq("ABC123")
        end
      end
    end

    describe "#all" do
      let!(:first_response_stub) do
        stub_request(:get, /.*api.gocardless.com\/users$/).to_return(
          body: {
            users: [{
              
              "created_at" => "created_at-input",
              "email" => "email-input",
              "enabled" => "enabled-input",
              "family_name" => "family_name-input",
              "given_name" => "given_name-input",
              "id" => "id-input",
              "links" => "links-input",
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
        stub_request(:get, /.*api.gocardless.com\/users\?after=AB345/).to_return(
          body: {
            users: [{
              
              "created_at" => "created_at-input",
              "email" => "email-input",
              "enabled" => "enabled-input",
              "family_name" => "family_name-input",
              "given_name" => "given_name-input",
              "id" => "id-input",
              "links" => "links-input",
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
        expect(client.users.all.to_a.length).to eq(2)
        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested
      end
    end

    
  
    

    
    describe "#get" do
      let(:id) { "ID123" }

      subject(:get_response) { client.users.get(id) }

      context "when there is a user to return" do
        before do
          stub_request(:get, /.*api.gocardless.com\/users\/ID123/).to_return(
            body: {
              users: {
                
                "created_at" => "created_at-input",
                "email" => "email-input",
                "enabled" => "enabled-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "links" => "links-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "wraps the response in a resource" do
          expect(get_response).to be_a(GoCardless::Resources::User)
        end
      end
    end

    
  
    

    
    describe "#update" do
      subject(:put_update_response) { client.users.update(id, update_params) }
      let(:id) { "ABC123" }

      context "with a valid request" do
        let(:update_params) { { "hello" => "world" } }

        let!(:stub) do
          stub_request(:put, /.*api.gocardless.com\/users\/ABC123/).to_return(
            body: {
              users: {
                
                "created_at" => "created_at-input",
                "email" => "email-input",
                "enabled" => "enabled-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "links" => "links-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "updates and returns the resource" do
          expect(put_update_response).to be_a(GoCardless::Resources::User)
          expect(stub).to have_been_requested
        end
      end
    end
    
  
    

    
    describe "#enable" do
      
      
        subject(:post_response) { client.users.enable(resource_id) }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /users/%v/actions/enable
        stub_url = "/users/:identity/actions/enable".gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            users: {
              
              "created_at" => "created_at-input",
              "email" => "email-input",
              "enabled" => "enabled-input",
              "family_name" => "family_name-input",
              "given_name" => "given_name-input",
              "id" => "id-input",
              "links" => "links-input",
            }
          }.to_json,
          headers: {'Content-Type' => 'application/json'},
        )
      end

      it "wraps the response and calls the right endpoint" do
        expect(post_response).to be_a(GoCardless::Resources::User)

        expect(stub).to have_been_requested
      end

      context "when the request needs a body and custom header" do
        
          let(:body) { { foo: 'bar' } }
          let(:headers) { { 'Foo' => 'Bar' } }
          subject(:post_response) { client.users.enable(resource_id, body, headers) }
        
        let(:resource_id) { "ABC123" }

        let!(:stub) do
          # /users/%v/actions/enable
          stub_url = "/users/:identity/actions/enable".gsub(':identity', resource_id)
          stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              users: {
                
                "created_at" => "created_at-input",
                "email" => "email-input",
                "enabled" => "enabled-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "links" => "links-input",
              }
            }.to_json,
            headers: {'Content-Type' => 'application/json'},
          )
        end
      end
    end
    
  
    

    
    describe "#disable" do
      
      
        subject(:post_response) { client.users.disable(resource_id) }
      
      let(:resource_id) { "ABC123" }

      let!(:stub) do
        # /users/%v/actions/disable
        stub_url = "/users/:identity/actions/disable".gsub(':identity', resource_id)
        stub_request(:post, /.*api.gocardless.com#{stub_url}/).to_return(
          body: {
            users: {
              
              "created_at" => "created_at-input",
              "email" => "email-input",
              "enabled" => "enabled-input",
              "family_name" => "family_name-input",
              "given_name" => "given_name-input",
              "id" => "id-input",
              "links" => "links-input",
            }
          }.to_json,
          headers: {'Content-Type' => 'application/json'},
        )
      end

      it "wraps the response and calls the right endpoint" do
        expect(post_response).to be_a(GoCardless::Resources::User)

        expect(stub).to have_been_requested
      end

      context "when the request needs a body and custom header" do
        
          let(:body) { { foo: 'bar' } }
          let(:headers) { { 'Foo' => 'Bar' } }
          subject(:post_response) { client.users.disable(resource_id, body, headers) }
        
        let(:resource_id) { "ABC123" }

        let!(:stub) do
          # /users/%v/actions/disable
          stub_url = "/users/:identity/actions/disable".gsub(':identity', resource_id)
          stub_request(:post, /.*api.gocardless.com#{stub_url}/).
          with(
            body: { foo: 'bar' },
            headers: { 'Foo' => 'Bar' }
          ).to_return(
            body: {
              users: {
                
                "created_at" => "created_at-input",
                "email" => "email-input",
                "enabled" => "enabled-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "links" => "links-input",
              }
            }.to_json,
            headers: {'Content-Type' => 'application/json'},
          )
        end
      end
    end
    
  
end
