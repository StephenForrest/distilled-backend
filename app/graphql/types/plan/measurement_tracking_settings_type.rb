# frozen_string_literal: true

module Types
  module Plan
    class MeasurementTrackingSettingsType < Types::BaseUnion
      description 'Serialize settings of settings'
      possible_types ::Types::Plan::Measurements::MeasurementSlackType

      def self.resolve_type(object, _context)
        raise GraphQL::ExecutionError, 'Invalid action' unless object.is_a?(::Measurements::Slack)

        ::Types::Plan::Measurements::MeasurementSlackType
      end
    end
  end
end
