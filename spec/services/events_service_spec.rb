require 'spec_helper'

describe GoCardlessPro::Services::EventsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: "SECRET_TOKEN"
    )
  end

  
  
  
    

    
    describe "#list" do
      describe "with no filters" do
        subject(:get_list_response) { client.events.list }

        before do
          stub_request(:get, %r(.*api.gocardless.com/events)).to_return(
            body: {
              "events" => [{
                
                "action" => "action-input",
                "created_at" => "created_at-input",
                "details" => "details-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "resource_type" => "resource_type-input",
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
          expect(get_list_response.records.map { |x| x.class }.uniq.first).to eq(GoCardlessPro::Resources::Event)

          
          
          expect(get_list_response.records.first.action).to eq("action-input")
          
          
          
          expect(get_list_response.records.first.created_at).to eq("created_at-input")
          
          
          
          expect(get_list_response.records.first.details).to eq("details-input")
          
          
          
          expect(get_list_response.records.first.id).to eq("id-input")
          
          
          
          
          
          expect(get_list_response.records.first.metadata).to eq("metadata-input")
          
          
          
          expect(get_list_response.records.first.resource_type).to eq("resource_type-input")
          
          
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
        stub_request(:get, %r(.*api.gocardless.com/events$)).to_return(
          body: {
            "events" => [{
              
              "action" => "action-input",
              "created_at" => "created_at-input",
              "details" => "details-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
              "resource_type" => "resource_type-input",
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
        stub_request(:get, %r(.*api.gocardless.com/events\?after=AB345)).to_return(
          body: {
            "events" => [{
              
              "action" => "action-input",
              "created_at" => "created_at-input",
              "details" => "details-input",
              "id" => "id-input",
              "links" => "links-input",
              "metadata" => "metadata-input",
              "resource_type" => "resource_type-input",
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
        expect(client.events.all.to_a.length).to eq(2)
        expect(first_response_stub).to have_been_requested
        expect(second_response_stub).to have_been_requested
      end
    end

    
  
    

    
    describe "#get" do
      let(:id) { "ID123" }

      subject(:get_response) { client.events.get(id) }

      context "passing in a custom header" do
        let!(:stub) do
          stub_url = "/events/:identity".gsub(':identity', id)
          stub_request(:get, %r(.*api.gocardless.com#{stub_url})).
          with(headers: { 'Foo' => 'Bar' }).
          to_return(
            body: {
              "events" => {
                
                "action" => "action-input",
                "created_at" => "created_at-input",
                "details" => "details-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "resource_type" => "resource_type-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        subject(:get_response) do
          client.events.get(id, headers: {
            'Foo' => 'Bar'
          })
        end

        it "includes the header" do
          get_response
          expect(stub).to have_been_requested
        end
      end

      context "when there is a event to return" do
        before do
          stub_url = "/events/:identity".gsub(':identity', id)
          stub_request(:get, %r(.*api.gocardless.com#{stub_url})).to_return(
            body: {
              "events" => {
                
                "action" => "action-input",
                "created_at" => "created_at-input",
                "details" => "details-input",
                "id" => "id-input",
                "links" => "links-input",
                "metadata" => "metadata-input",
                "resource_type" => "resource_type-input",
              }
            }.to_json,
            :headers => {'Content-Type' => 'application/json'}
          )
        end

        it "wraps the response in a resource" do
          expect(get_response).to be_a(GoCardlessPro::Resources::Event)
        end
      end

      context "when nothing is returned" do
        before do
          stub_url = "/events/:identity".gsub(':identity', id)
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

    
  
end
