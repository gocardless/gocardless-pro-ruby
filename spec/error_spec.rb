require 'spec_helper'

describe GoCardlessPro::Error do
  subject(:error) { described_class.new(api_error) }

  let(:api_error) do
    {
      "documentation_url" => "https://developer.gocardless.com/pro#validation_failed",
      "message" => "Validation failed",
      "type" => "validation_failed",
      "code" => 422,
      "request_id" => "dd50eaaf-8213-48fe-90d6-5466872efbc4",
      "errors" => [
        {
          "message" => "must be a number",
          "field" => "branch_code"
        }, {
          "message" => "is the wrong length (should be 8 characters)",
          "field" => "branch_code"
        }
      ]
    }
  end

  specify do
    expect(error.documentation_url).to eq("https://developer.gocardless.com/pro#validation_failed")
  end

  specify { expect(error.message).to eq("Validation failed") }
  specify { expect(error.to_s).to eq("Validation failed") }
  specify { expect(error.type).to eq("validation_failed") }
  specify { expect(error.code).to eq(422) }
  specify { expect(error.request_id).to eq("dd50eaaf-8213-48fe-90d6-5466872efbc4") }
  specify do
    expect(error.errors).to eq([
      {
        "message" => "must be a number",
        "field" => "branch_code"
      }, {
        "message" => "is the wrong length (should be 8 characters)",
        "field" => "branch_code"
      }
    ])
  end
end
