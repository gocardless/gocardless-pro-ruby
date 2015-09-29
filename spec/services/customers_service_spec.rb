require 'spec_helper'

describe GoCardlessPro::Services::CustomersService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: "SECRET_TOKEN"
    )
  end

  
  
  
    

    
    describe "#create" do
    subject(:post_create_response) { client.customers.create(params: new_resource) }
      context "with a valid request" do
        let(:new_resource) do
          {
          
          "address_line1" => "address_line1-input",
          "address_line2" => "address_line2-input",
          "address_line3" => "address_line3-input",
          "city" => "city-input",
          "company_name" => "company_name-input",
          "country_code" => "country_code-input",
          "created_at" => "created_at-input",
          "email" => "email-input",
          "family_name" => "family_name-input",
          "given_name" => "given_name-input",
          "id" => "id-input",
          "language" => "language-input",
          "metadata" => "metadata-input",
          "postal_code" => "postal_code-input",
          "region" => "region-input",
          "swedish_identity_number" => "swedish_identity_number-input",
          }
        end

        before do
          stub_request(:post, %r(.*api.gocardless.com/customers)).
          with(
            body: {
              "customers" => {
                
                "address_line1" => "address_line1-input",
                "address_line2" => "address_line2-input",
                "address_line3" => "address_line3-input",
                "city" => "city-input",
                "company_name" => "company_name-input",
                "country_code" => "country_code-input",
                "created_at" => "created_at-input",
                "email" => "email-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "language" => "language-input",
                "metadata" => "metadata-input",
                "postal_code" => "postal_code-input",
                "region" => "region-input",
                "swedish_identity_number" => "swedish_identity_number-input",
                }
            }
          ).
          to_return(
            body: {
              "customers" => {
                
                "address_line1" => "address_line1-input",
                "address_line2" => "address_line2-input",
                "address_line3" => "address_line3-input",
                "city" => "city-input",
                "company_name" => "company_name-input",
                "country_code" => "country_code-input",
                "created_at" => "created_at-input",
                "email" => "email-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "language" => "language-input",
                "metadata" => "metadata-input",
                "postal_code" => "postal_code-input",
                "region" => "region-input",
                "swedish_identity_number" => "swedish_identity_number-input",
                }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "creates and returns the resource" do
          expect(post_create_response).to be_a(GoCardlessPro::Resources::Customer)
        end
      end

      context "with a request that returns a validation error" do
        let(:new_resource) { {} }

        before do
          stub_request(:post, %r(.*api.gocardless.com/customers)).to_return(
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
    
  
    

    
    describe "#list" do
      describe "with no filters" do
        subject(:get_list_response) { client.customers.list }

        before do
          stub_request(:get, %r(.*api.gocardless.com/customers)).to_return(
            body: {
              "customers" => [{
                
                "address_line1" => "address_line1-input",
                "address_line2" => "address_line2-input",
                "address_line3" => "address_line3-input",
                "city" => "city-input",
                "company_name" => "company_name-input",
                "country_code" => "country_code-input",
                "created_at" => "created_at-input",
                "email" => "email-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "language" => "language-input",
                "metadata" => "metadata-input",
                "postal_code" => "postal_code-input",
                "region" => "region-input",
                "swedish_identity_number" => "swedish_identity_number-input",
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
          expect(get_list_response.records.map { |x| x.class }.uniq.first).to eq(GoCardlessPro::Resources::Customer)

          
          
          expect(get_list_response.records.first.address_line1).to eq("address_line1-input")
          
          
          
          expect(get_list_response.records.first.address_line2).to eq("address_line2-input")
          
          
          
          expect(get_list_response.records.first.address_line3).to eq("address_line3-input")
          
          
          
          expect(get_list_response.records.first.city).to eq("city-input")
          
          
          
          expect(get_list_response.records.first.company_name).to eq("company_name-input")
          
          
          
          expect(get_list_response.records.first.country_code).to eq("country_code-input")
          
          
          
          expect(get_list_response.records.first.created_at).to eq("created_at-input")
          
          
          
          expect(get_list_response.records.first.email).to eq("email-input")
          
          
          
          expect(get_list_response.records.first.family_name).to eq("family_name-input")
          
          
          
          expect(get_list_response.records.first.given_name).to eq("given_name-input")
          
          
          
          expect(get_list_response.records.first.id).to eq("id-input")
          
          
          
          expect(get_list_response.records.first.language).to eq("language-input")
          
          
          
          expect(get_list_response.records.first.metadata).to eq("metadata-input")
          
          
          
          expect(get_list_response.records.first.postal_code).to eq("postal_code-input")
          
          
          
          expect(get_list_response.records.first.region).to eq("region-input")
          
          
          
          expect(get_list_response.records.first.swedish_identity_number).to eq("swedish_identity_number-input")
          
          
        end

        it "exposes the cursors for before and after" do
          expect(get_list_response.before).to eq(nil)
          expect(get_list_response.after).to eq("ABC123")
        end

        specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }
      end
    end

    describe "#all" do
      let!(:first_response_stub) do
        stub_request(:get, %r(.*api.gocardless.com/customers$)).to_return(
          body: {
            "customers" => [{
              
              "address_line1" => "address_line1-input",
              "address_line2" => "address_line2-input",
              "address_line3" => "address_line3-input",
              "city" => "city-input",
              "company_name" => "company_name-input",
              "country_code" => "country_code-input",
              "created_at" => "created_at-input",
              "email" => "email-input",
              "family_name" => "family_name-input",
              "given_name" => "given_name-input",
              "id" => "id-input",
              "language" => "language-input",
              "metadata" => "metadata-input",
              "postal_code" => "postal_code-input",
              "region" => "region-input",
              "swedish_identity_number" => "swedish_identity_number-input",
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
        stub_request(:get, %r(.*api.gocardless.com/customers\?after=AB345)).to_return(
          body: {
            "customers" => [{
              
              "address_line1" => "address_line1-input",
              "address_line2" => "address_line2-input",
              "address_line3" => "address_line3-input",
              "city" => "city-input",
              "company_name" => "company_name-input",
              "country_code" => "country_code-input",
              "created_at" => "created_at-input",
              "email" => "email-input",
              "family_name" => "family_name-input",
              "given_name" => "given_name-input",
              "id" => "id-input",
              "language" => "language-input",
              "metadata" => "metadata-input",
              "postal_code" => "postal_code-input",
              "region" => "region-input",
              "swedish_identity_number" => "swedish_identity_number-input",
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
        expect(client.customers.all.to_a.length).to eq(2)
        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested
      end
    end

    
  
    

    
    describe "#get" do
      let(:id) { "ID123" }

      subject(:get_response) { client.customers.get(id) }

      context "passing in a custom header" do
        let!(:stub) do
          stub_url = "/customers/:identity".gsub(':identity', id)
          stub_request(:get, %r(.*api.gocardless.com#{stub_url})).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              "customers" => {
                
                "address_line1" => "address_line1-input",
                "address_line2" => "address_line2-input",
                "address_line3" => "address_line3-input",
                "city" => "city-input",
                "company_name" => "company_name-input",
                "country_code" => "country_code-input",
                "created_at" => "created_at-input",
                "email" => "email-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "language" => "language-input",
                "metadata" => "metadata-input",
                "postal_code" => "postal_code-input",
                "region" => "region-input",
                "swedish_identity_number" => "swedish_identity_number-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        subject(:get_response) do
          client.customers.get(id, headers: {
            'Foo' => 'Bar'
          })
        end

        it "includes the header" do
          get_response
          expect(stub).to have_been_requested
        end
      end

      context "when there is a customer to return" do
        before do
          stub_url = "/customers/:identity".gsub(':identity', id)
          stub_request(:get, %r(.*api.gocardless.com#{stub_url})).to_return(
            body: {
              "customers" => {
                
                "address_line1" => "address_line1-input",
                "address_line2" => "address_line2-input",
                "address_line3" => "address_line3-input",
                "city" => "city-input",
                "company_name" => "company_name-input",
                "country_code" => "country_code-input",
                "created_at" => "created_at-input",
                "email" => "email-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "language" => "language-input",
                "metadata" => "metadata-input",
                "postal_code" => "postal_code-input",
                "region" => "region-input",
                "swedish_identity_number" => "swedish_identity_number-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "wraps the response in a resource" do
          expect(get_response).to be_a(GoCardlessPro::Resources::Customer)
        end
      end

      context "when nothing is returned" do
        before do
          stub_url = "/customers/:identity".gsub(':identity', id)
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

    
  
    

    
    describe "#update" do
      subject(:put_update_response) { client.customers.update(id, params: update_params) }
      let(:id) { "ABC123" }

      context "with a valid request" do
        let(:update_params) { { "hello" => "world" } }

        let!(:stub) do
          stub_url = "/customers/:identity".gsub(':identity', id)
          stub_request(:put, %r(.*api.gocardless.com#{stub_url})).to_return(
            body: {
              "customers" => {
                
                "address_line1" => "address_line1-input",
                "address_line2" => "address_line2-input",
                "address_line3" => "address_line3-input",
                "city" => "city-input",
                "company_name" => "company_name-input",
                "country_code" => "country_code-input",
                "created_at" => "created_at-input",
                "email" => "email-input",
                "family_name" => "family_name-input",
                "given_name" => "given_name-input",
                "id" => "id-input",
                "language" => "language-input",
                "metadata" => "metadata-input",
                "postal_code" => "postal_code-input",
                "region" => "region-input",
                "swedish_identity_number" => "swedish_identity_number-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "updates and returns the resource" do
          expect(put_update_response).to be_a(GoCardlessPro::Resources::Customer)
          expect(stub).to have_been_requested
        end
      end
    end
    
  
end
