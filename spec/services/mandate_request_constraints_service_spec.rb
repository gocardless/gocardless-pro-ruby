require 'spec_helper'

describe GoCardlessPro::Services::MandateRequestConstraintsService do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }
end
