# frozen_string_literal: true

module Types
  module Plan
    module Measurements
      class MeasurementSlackActionLogsType < Types::BaseObject
        field :id, String, null: false
        field :metric, String, null: false
        field :value, String, null: false
        field :created_at, String, null: false
      end
    end
  end
end
