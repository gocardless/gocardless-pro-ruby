require 'spec_helper'

# Code Sample Tests
# These tests verify that the documentation code samples are syntactically valid
# and can execute against a mocked API without errors.
#
# IMPORTANT: These tests do NOT verify business logic - they only verify that
# the code samples compile and execute without syntax errors.

describe 'InstalmentSchedules Code Samples' do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create_with_dates code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/instalment_schedules'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'instalment_schedules' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.instalment_schedules.create_with_dates(
        params: {
          name: 'ACME Invoice 103',
          total_amount: 10_000, # 100 GBP in pence, collected from the customer
          app_fee: 10, # Your 10 pence fee, applied to each instalment,
          # to be paid out to you
          currency: 'GBP',
          instalments: [
            {
              charge_date: '2019-08-20',
              amount: 3_400,
            },
            {
              charge_date: '2019-09-03',
              amount: 3_400,
            },
            {
              charge_date: '2019-09-17',
              amount: 3_200,
            },
          ],
          links: {
            mandate: 'MD0000XH9A3T4C',
          },
          metadata: {},
        },
        headers: {
          'Idempotency-Key': 'random_instalment_schedule_specific_string',
        }
      )
    end
  end

  describe '#create_with_schedule code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/instalment_schedules'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'instalment_schedules' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.instalment_schedules.create_with_schedule(
        params: {
          name: 'ACME Invoice 103',
          total_amount: 10_000, # 100 GBP in pence, collected from the customer
          app_fee: 10, # Your 10 pence fee, applied to each instalment,
          # to be paid out to you
          currency: 'GBP',
          instalments: {
            start_date: '2019-08-20',
            interval_unit: 'weekly',
            interval: 2,
            amounts: [
              3_400,
              3_400,
              3_200,
            ],
          },
          links: {
            mandate: 'MD0000XH9A3T4C',
          },
          metadata: {},
        },
        headers: {
          'Idempotency-Key': 'random_instalment_schedule_specific_string',
        }
      )
    end
  end

  describe '#list code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/instalment_schedules'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'instalment_schedules' => [{}], 'meta' => { 'cursors' => {}, 'limit' => 50 } }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.instalment_schedules.list

      @client.instalment_schedules.list(
        params: {
          'created_at[gt]' => '2016-08-06T09:30:00Z',
        }
      )

      @client.instalment_schedules.list.records.each do |instalment_schedule|
        puts instalment_schedule.inspect
      end
    end
  end

  describe '#get code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/instalment_schedules/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:get, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'instalment_schedules' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.instalment_schedules.get('IS123')
    end
  end

  describe '#update code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/instalment_schedules/:identity'.gsub(/:\w+/, '[^/]+')
      stub_request(:put, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'instalment_schedules' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.instalment_schedules.update(
        'IS123',
        params: {
          metadata: { key: 'value' },
        }
      )
    end
  end

  describe '#cancel code sample' do
    before do
      # Convert :param placeholders to regex wildcards for flexible matching
      stub_url = '/instalment_schedules/:identity/actions/cancel'.gsub(/:\w+/, '[^/]+')
      stub_request(:post, /.*api.gocardless.com#{stub_url}/).
        to_return(
          body: { 'instalment_schedules' => {} }.to_json,
          headers: response_headers
        )
    end

    it 'executes without error' do
      @client = client
      @client.instalment_schedules.cancel('IS123')
    end
  end
end
