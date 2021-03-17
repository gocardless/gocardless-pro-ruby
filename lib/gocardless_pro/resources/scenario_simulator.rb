# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a scenario_simulator resource returned from the API

    # Scenario Simulators allow you to manually trigger and test certain paths
    # that your
    # integration will encounter in the real world. These endpoints are only
    # active in the
    # sandbox environment.
    class ScenarioSimulator
      attr_reader :description
      attr_reader :id
      attr_reader :name
      attr_reader :resource_type

      # Initialize a scenario_simulator resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @description = object['description']
        @id = object['id']
        @name = object['name']
        @resource_type = object['resource_type']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the scenario_simulator resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
