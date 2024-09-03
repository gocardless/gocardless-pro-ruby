require 'spec_helper'

describe GoCardlessPro::Resources::VerificationDetail do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.verification_details.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'address_line1' => 'address_line1-input',
          'address_line2' => 'address_line2-input',
          'address_line3' => 'address_line3-input',
          'city' => 'city-input',
          'company_number' => 'company_number-input',
          'description' => 'description-input',
          'directors' => 'directors-input',
          'links' => 'links-input',
          'name' => 'name-input',
          'postal_code' => 'postal_code-input'
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/verification_details})
          .with(
            body: {
              'verification_details' => {

                'address_line1' => 'address_line1-input',
                'address_line2' => 'address_line2-input',
                'address_line3' => 'address_line3-input',
                'city' => 'city-input',
                'company_number' => 'company_number-input',
                'description' => 'description-input',
                'directors' => 'directors-input',
                'links' => 'links-input',
                'name' => 'name-input',
                'postal_code' => 'postal_code-input'
              }
            }
          )
          .to_return(
            body: {
              'verification_details' =>

                {

                  'address_line1' => 'address_line1-input',
                  'address_line2' => 'address_line2-input',
                  'address_line3' => 'address_line3-input',
                  'city' => 'city-input',
                  'company_number' => 'company_number-input',
                  'description' => 'description-input',
                  'directors' => 'directors-input',
                  'links' => 'links-input',
                  'name' => 'name-input',
                  'postal_code' => 'postal_code-input'
                }

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::VerificationDetail)
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/verification_details}).to_return(
          body: {
            error: {
              type: 'validation_failed',
              code: 422,
              errors: [
                { message: 'test error message', field: 'test_field' }
              ]
            }
          }.to_json,
          headers: response_headers,
          status: 422
        )
      end

      it 'throws the correct error' do
        expect { post_create_response }.to raise_error(GoCardlessPro::ValidationError)
      end
    end

    context 'with a request that returns an idempotent creation conflict error' do
      let(:id) { 'ID123' }

      let(:new_resource) do
        {

          'address_line1' => 'address_line1-input',
          'address_line2' => 'address_line2-input',
          'address_line3' => 'address_line3-input',
          'city' => 'city-input',
          'company_number' => 'company_number-input',
          'description' => 'description-input',
          'directors' => 'directors-input',
          'links' => 'links-input',
          'name' => 'name-input',
          'postal_code' => 'postal_code-input'
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/verification_details}).to_return(
          body: {
            error: {
              type: 'invalid_state',
              code: 409,
              errors: [
                {
                  message: 'A resource has already been created with this idempotency key',
                  reason: 'idempotent_creation_conflict',
                  links: {
                    conflicting_resource_id: id
                  }
                }
              ]
            }
          }.to_json,
          headers: response_headers,
          status: 409
        )
      end

      it 'raises an InvalidStateError' do
        expect { post_create_response }.to raise_error(GoCardlessPro::InvalidStateError)
        expect(post_stub).to have_been_requested
      end
    end
  end

  describe '#list' do
    describe 'with no filters' do
      subject(:get_list_response) { client.verification_details.list }

      before do
        stub_request(:get, %r{.*api.gocardless.com/verification_details}).to_return(
          body: {
            'verification_details' => [{

              'address_line1' => 'address_line1-input',
              'address_line2' => 'address_line2-input',
              'address_line3' => 'address_line3-input',
              'city' => 'city-input',
              'company_number' => 'company_number-input',
              'description' => 'description-input',
              'directors' => 'directors-input',
              'links' => 'links-input',
              'name' => 'name-input',
              'postal_code' => 'postal_code-input'
            }],
            meta: {
              cursors: {
                before: nil,
                after: 'ABC123'
              }
            }
          }.to_json,
          headers: response_headers
        )
      end

      it 'wraps each item in the resource class' do
        expect(get_list_response.records.map do |x|
                 x.class
               end.uniq.first).to eq(GoCardlessPro::Resources::VerificationDetail)

        expect(get_list_response.records.first.address_line1).to eq('address_line1-input')

        expect(get_list_response.records.first.address_line2).to eq('address_line2-input')

        expect(get_list_response.records.first.address_line3).to eq('address_line3-input')

        expect(get_list_response.records.first.city).to eq('city-input')

        expect(get_list_response.records.first.company_number).to eq('company_number-input')

        expect(get_list_response.records.first.description).to eq('description-input')

        expect(get_list_response.records.first.directors).to eq('directors-input')

        expect(get_list_response.records.first.name).to eq('name-input')

        expect(get_list_response.records.first.postal_code).to eq('postal_code-input')
      end

      it 'exposes the cursors for before and after' do
        expect(get_list_response.before).to eq(nil)
        expect(get_list_response.after).to eq('ABC123')
      end

      specify { expect(get_list_response.api_response.headers).to eql('content-type' => 'application/json') }
    end
  end

  describe '#all' do
    let!(:first_response_stub) do
      stub_request(:get, %r{.*api.gocardless.com/verification_details$}).to_return(
        body: {
          'verification_details' => [{

            'address_line1' => 'address_line1-input',
            'address_line2' => 'address_line2-input',
            'address_line3' => 'address_line3-input',
            'city' => 'city-input',
            'company_number' => 'company_number-input',
            'description' => 'description-input',
            'directors' => 'directors-input',
            'links' => 'links-input',
            'name' => 'name-input',
            'postal_code' => 'postal_code-input'
          }],
          meta: {
            cursors: { after: 'AB345' },
            limit: 1
          }
        }.to_json,
        headers: response_headers
      )
    end

    let!(:second_response_stub) do
      stub_request(:get, %r{.*api.gocardless.com/verification_details\?after=AB345}).to_return(
        body: {
          'verification_details' => [{

            'address_line1' => 'address_line1-input',
            'address_line2' => 'address_line2-input',
            'address_line3' => 'address_line3-input',
            'city' => 'city-input',
            'company_number' => 'company_number-input',
            'description' => 'description-input',
            'directors' => 'directors-input',
            'links' => 'links-input',
            'name' => 'name-input',
            'postal_code' => 'postal_code-input'
          }],
          meta: {
            limit: 2,
            cursors: {}
          }
        }.to_json,
        headers: response_headers
      )
    end

    it 'automatically makes the extra requests' do
      expect(client.verification_details.all.to_a.length).to eq(2)
      expect(first_response_stub).to have_been_requested
      expect(second_response_stub).to have_been_requested
    end
  end
end
