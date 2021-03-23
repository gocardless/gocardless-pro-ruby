require_relative './base_service'

# encoding: utf-8
#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

module GoCardlessPro
  module Services
    # Service for making requests to the ScenarioSimulator endpoints
    class ScenarioSimulatorsService < BaseService
      # Runs the specific scenario simulator against the specific resource
      # Example URL: /scenario_simulators/:identity/actions/run
      #
      # @param identity       # The unique identifier of the simulator, used to initiate simulations.
      # One of:
      # <ul>
      # <li>`creditor_verification_status_action_required`</li>
      # <li>`creditor_verification_status_in_review`</li>
      # <li>`creditor_verification_status_successful`</li>
      # <li>`payment_paid_out`</li>
      # <li>`payment_failed`</li>
      # <li>`payment_charged_back`</li>
      # <li>`payment_chargeback_settled`</li>
      # <li>`payment_late_failure`</li>
      # <li>`payment_late_failure_settled`</li>
      # <li>`payment_submitted`</li>
      # <li>`mandate_activated`</li>
      # <li>`mandate_failed`</li>
      # <li>`mandate_expired`</li>
      # <li>`mandate_transferred`</li>
      # <li>`mandate_transferred_with_resubmission`</li>
      # <li>`refund_paid`</li>
      # <li>`payout_bounced`</li>
      # </ul>
      # @param options [Hash] parameters as a hash, under a params key.
      def run(identity, options = {})
        path = sub_url('/scenario_simulators/:identity/actions/run', 'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params

        options[:retry_failures] = false

        response = make_request(:post, path, options)

        return if response.body.nil?

        Resources::ScenarioSimulator.new(unenvelope_body(response.body), response)
      end

      private

      # Unenvelope the response of the body using the service's `envelope_key`
      #
      # @param body [Hash]
      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      # return the key which API responses will envelope data under
      def envelope_key
        'scenario_simulators'
      end
    end
  end
end
