# frozen_string_literal: true

module Resolvers
  class GetSlackActionLogs < BaseResolver
    # outputs
    type [Types::Plan::Measurements::MeasurementSlackActionLogsType], null: false
    argument :measurements_slack_id, String, required: true

    def resolve(measurements_slack_id:)
      slack_measurement = current_workspace.measurements_slacks.find(measurements_slack_id)
      slack_measurement.measurement_slack_action_logs
    end
  end
end
