# encoding: utf-8

#
# This client is automatically generated from a template and JSON schema definition.
# See https://github.com/gocardless/gocardless-pro-ruby#contributing before editing.
#

require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Represents an instance of a mandate_import resource returned from the API

    # Mandate Imports allow you to migrate existing mandates from other
    # providers into the
    # GoCardless platform.
    #
    # The process is as follows:
    #
    #   1. [Create a mandate
    # import](#mandate-imports-create-a-new-mandate-import)
    #   2. [Add entries](#mandate-import-entries-add-a-mandate-import-entry) to
    # the import
    #   3. [Submit](#mandate-imports-submit-a-mandate-import) the import
    #   4. Wait until a member of the GoCardless team approves the import, at
    # which point the mandates will be created
    #   5. [Link up the
    # mandates](#mandate-import-entries-list-all-mandate-import-entries) in your
    # system
    #
    # When you add entries to your mandate import, they are not turned into
    # actual mandates
    # until the mandate import is submitted by you via the API, and then
    # processed by a member
    # of the GoCardless team. When that happens, a mandate will be created for
    # each entry in the import.
    #
    # We will issue a `mandate_created` webhook for each entry, which will be
    # the same as the webhooks
    # triggered when [ creating a mandate ](#mandates-create-a-mandate) using
    # the mandates API. Once these
    # webhooks start arriving, any reconciliation can now be accomplished by
    # [checking the current status](#mandate-imports-get-a-mandate-import) of
    # the mandate import and
    # [linking up the mandates to your
    # system](#mandate-import-entries-list-all-mandate-import-entries).
    #
    # <p class="notice">Note that all Mandate Imports have an upper limit of
    # 30,000 entries, so
    # we recommend you split your import into several smaller imports if you're
    # planning to
    # exceed this threshold.</p>
    #
    # <p class="restricted-notice"><strong>Restricted</strong>: This API is
    # currently
    # only available for approved partners - please <a
    # href="mailto:help@gocardless.com">get
    # in touch</a> if you would like to use this API.</p>
    class MandateImport
      attr_reader :created_at
      attr_reader :id
      attr_reader :scheme
      attr_reader :status

      # Initialize a mandate_import resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @created_at = object['created_at']
        @id = object['id']
        @scheme = object['scheme']
        @status = object['status']
        @response = response
      end

      def api_response
        ApiResponse.new(@response)
      end

      # Provides the mandate_import resource as a hash of all its readable attributes
      def to_h
        @object
      end
    end
  end
end
