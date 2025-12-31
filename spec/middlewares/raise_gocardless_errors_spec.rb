require 'spec_helper'

describe GoCardlessPro::Middlewares::RaiseGoCardlessErrors do
  let(:connection) do
    Faraday.new do |faraday|
      faraday.response :raise_gocardless_errors
      faraday.adapter :net_http
    end
  end

  before do
    stub_request(:post, 'https://api.gocardless.com/widgets').to_return(status: status,
                                                                        body: body,
                                                                        headers: headers)
  end

  let(:body) { nil }
  let(:headers) { { 'Content-Type' => 'application/json' } }

  context 'with a non-JSON response' do
    let(:body) { '<html><body>Response from Cloudflare</body></html>' }
    let(:headers) { { 'Content-Type' => 'text/html' } }
    let(:status) { 514 }

    it 'raises an error' do
      expect { connection.post('https://api.gocardless.com/widgets') }
        .to raise_error(GoCardlessPro::ApiError)
    end
  end

  context 'with a 5XX response' do
    let(:status) { 503 }

    it 'raises an error' do
      expect { connection.post('https://api.gocardless.com/widgets') }
        .to raise_error(GoCardlessPro::ApiError)
    end
  end

  context 'with a 2XX response' do
    let(:status) { 200 }

    it "doesn't raise an error" do
      expect { connection.post('https://api.gocardless.com/widgets') }
        .to_not raise_error(GoCardlessPro::ApiError)
    end
  end

  context 'with a 4XX response' do
    context 'for a validation error' do
      let(:raw_response) do
        double('response',
               headers: default_headers,
               status: 400,
               body: { error: { type: 'validation_failed' } }.to_json)
      end

      let(:status) { 422 }
      let(:body) { { error: { type: 'validation_failed' } }.to_json }

      it 'raises a ValidationError' do
        expect { connection.post('https://api.gocardless.com/widgets') }
          .to raise_error(GoCardlessPro::ValidationError)
      end
    end

    context 'for a GoCardless error' do
      let(:status) { 500 }
      let(:body) { { error: { type: 'gocardless' } }.to_json }

      it 'raises a GoCardlessError' do
        expect { connection.post('https://api.gocardless.com/widgets') }
          .to raise_error(GoCardlessPro::GoCardlessError)
      end
    end

    context 'for a Permission error' do
      let(:status) { 403 }
      let(:body) { { error: { type: 'invalid_api_usage' } }.to_json }

      it 'raises a GoCardlessError' do
        expect { connection.post('https://api.gocardless.com/widgets') }
          .to raise_error(GoCardlessPro::PermissionError)
      end
    end

    context 'for a RateLimit error' do
      let(:status) { 429 }
      let(:body) { { error: { type: 'invalid_api_usage' } }.to_json }

      it 'raises a GoCardlessError' do
        expect { connection.post('https://api.gocardless.com/widgets') }
          .to raise_error(GoCardlessPro::RateLimitError)
      end
    end

    context 'for a Authentication error' do
      let(:status) { 401 }
      let(:body) { { error: { type: 'invalid_api_usage' } }.to_json }

      it 'raises a GoCardlessError' do
        expect { connection.post('https://api.gocardless.com/widgets') }
          .to raise_error(GoCardlessPro::AuthenticationError)
      end
    end

    context 'for an invalid API usage error' do
      let(:status) { 400 }
      let(:body) { { error: { type: 'invalid_api_usage' } }.to_json }

      it 'raises a InvalidApiUsageError' do
        expect { connection.post('https://api.gocardless.com/widgets') }
          .to raise_error(GoCardlessPro::InvalidApiUsageError)
      end
    end

    context 'for an invalid state error' do
      let(:status) { 422 }
      let(:body) { { error: { type: 'invalid_state' } }.to_json }

      it 'raises an InvalidStateError' do
        expect { connection.post('https://api.gocardless.com/widgets') }
          .to raise_error(GoCardlessPro::InvalidStateError)
      end
    end
  end
end
