require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'BillingRequests Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_requests'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_requests' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_requests.create(
        params: {
          payment_request: {
            description: 'First Payment',
            amount: '500',
            currency: 'GBP',
          },
          mandate_request: {
            scheme: 'bacs',
          },
        }
      )
    end
  end

  describe '#collect_customer_details code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_requests/:identity/actions/collect_customer_details'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_requests' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_requests.collect_customer_details('BR123', {
                                                          params: {
                                                            customer: {
                                                              email: 'alice@example.com',
                                                              given_name: 'Alice',
                                                              family_name: 'Smith',
                                                            },
                                                            customer_billing_detail: {
                                                              address_line1: '1 Somewhere Lane',
                                                            },
                                                          },
                                                        })
    end
  end

  describe '#collect_bank_account code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_requests/:identity/actions/collect_bank_account'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_requests' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_requests.collect_bank_account('BR123', {
                                                      params: {
                                                        account_number: '55779911',
                                                        branch_code: '200000',
                                                        account_holder_name: 'Frank Osborne',
                                                        country_code: 'GB',
                                                      },
                                                    })
    end
  end

  describe '#confirm_payer_details code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_requests/:identity/actions/confirm_payer_details'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_requests' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_requests.confirm_payer_details('BR123')
    end
  end

  describe '#fulfil code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_requests/:identity/actions/fulfil'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_requests' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_requests.fulfil('BR123')
    end
  end

  describe '#cancel code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_requests/:identity/actions/cancel'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_requests' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_requests.cancel('BR123')
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_requests'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_requests' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_requests.list
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_requests/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_requests' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_requests.get('BR123')
    end
  end

  describe '#notify code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/billing_requests/:identity/actions/notify'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'billing_requests' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.billing_requests.notify('BR123', {
                                        params: {
                                          notification_type: 'email',
                                          redirect_uri: 'https://my-company.com',
                                        },
                                      })
    end
  end
end
