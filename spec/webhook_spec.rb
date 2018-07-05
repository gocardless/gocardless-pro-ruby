require 'spec_helper'
require 'pathname'

describe GoCardlessPro::Webhook do
  let(:options) do
    {
      request_body: request_body,
      signature_header: signature_header,
      webhook_endpoint_secret: webhook_endpoint_secret,
    }
  end

  let(:request_body) do
    '{"events":[{"id":"EV00BD05S5VM2T","created_at":"2018-07-05T09:13:51.404Z","resou' \
    'rce_type":"subscriptions","action":"created","links":{"subscription":"SB0003JJQ2' \
    'MR06"},"details":{"origin":"api","cause":"subscription_created","description":"S' \
    'ubscription created via the API."},"metadata":{}},{"id":"EV00BD05TB8K63","create' \
    'd_at":"2018-07-05T09:13:56.893Z","resource_type":"mandates","action":"created","' \
    'links":{"mandate":"MD000AMA19XGEC"},"details":{"origin":"api","cause":"mandate_c' \
    'reated","description":"Mandate created via the API."},"metadata":{}}]}'
  end

  let(:signature_header) do
    '2693754819d3e32d7e8fcb13c729631f316c6de8dc1cf634d6527f1c07276e7e'
  end

  let(:webhook_endpoint_secret) { 'ED7D658C-D8EB-4941-948B-3973214F2D49' }

  describe '.parse' do
    context 'when the signature in the header matches the computed signature' do
      it 'returns an array of `GoCardlessPro::Resources::Event`s' do
        events = described_class.parse(options)

        expect(events.length).to eq(2)

        expect(events.first.id).to eq('EV00BD05S5VM2T')
        expect(events.first.created_at).to eq('2018-07-05T09:13:51.404Z')
        expect(events.first.resource_type).to eq('subscriptions')
        expect(events.first.action).to eq('created')
        expect(events.first.links.subscription).to eq('SB0003JJQ2MR06')
        expect(events.first.details['origin']).to eq('api')
        expect(events.first.details['cause']).to eq('subscription_created')
        expect(events.first.details['description']).
          to eq('Subscription created via the API.')
        expect(events.first.metadata).to eq({})

        expect(events.last.id).to eq('EV00BD05TB8K63')
        expect(events.last.created_at).to eq('2018-07-05T09:13:56.893Z')
        expect(events.last.resource_type).to eq('mandates')
        expect(events.last.action).to eq('created')
        expect(events.last.links.mandate).to eq('MD000AMA19XGEC')
        expect(events.last.details['origin']).to eq('api')
        expect(events.last.details['cause']).to eq('mandate_created')
        expect(events.last.details['description']).
          to eq('Mandate created via the API.')
        expect(events.last.metadata).to eq({})
      end
    end

    context "when the signature in the header doesn't match the computed signature" do
      let(:webhook_endpoint_secret) { 'foo' }

      it 'raises an InvalidSignatureError' do
        expect { described_class.parse(options) }.
          to raise_error(described_class::InvalidSignatureError,
                         /doesn't appear to be a genuine webhook from GoCardless/)
      end
    end

    context 'with a required argument missing' do
      before { options.delete(:request_body) }

      it 'raises an ArgumentError' do
        expect { described_class.signature_valid?(options) }.
          to raise_error(ArgumentError,
                         'request_body must be provided and must be a string')
      end
    end

    context 'with an argument of the wrong type' do
      let(:request_body) { StringIO.new }

      it 'raises an ArgumentError' do
        expect { described_class.signature_valid?(options) }.
          to raise_error(ArgumentError,
                         'request_body must be provided and must be a string')
      end
    end
  end

  describe '.signature_valid?' do
    context 'when the signature in the header matches the computed signature' do
      specify { expect(described_class.signature_valid?(options)).to be(true) }
    end

    context "when the signature in the header doesn't match the computed signature" do
      let(:webhook_endpoint_secret) { 'foo' }

      specify { expect(described_class.signature_valid?(options)).to be(false) }
    end

    context 'with a required argument missing' do
      before { options.delete(:request_body) }

      it 'raises an ArgumentError' do
        expect { described_class.signature_valid?(options) }.
          to raise_error(ArgumentError,
                         'request_body must be provided and must be a string')
      end
    end

    context 'with an argument of the wrong type' do
      let(:request_body) { StringIO.new }

      it 'raises an ArgumentError' do
        expect { described_class.signature_valid?(options) }.
          to raise_error(ArgumentError,
                         'request_body must be provided and must be a string')
      end
    end
  end
end
