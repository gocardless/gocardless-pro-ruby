module GoCardlessPro
  # Thrown when the API returns an invalid state error
  class InvalidStateError < Error
    IDEMPOTENT_CREATION_CONFLICT = 'idempotent_creation_conflict'.freeze
    CONFLICTING_RESOURCE_ID = 'conflicting_resource_id'.freeze

    def idempotent_creation_conflict?
      !idempotent_creation_conflict_error.nil?
    end

    def conflicting_resource_id
      return unless idempotent_creation_conflict?

      idempotent_creation_conflict_error['links'][CONFLICTING_RESOURCE_ID]
    end

    private

    def idempotent_creation_conflict_error
      errors.find { |error| error['reason'] == IDEMPOTENT_CREATION_CONFLICT }
    end
  end

  IdempotencyConflict = Class.new(Error)
end
