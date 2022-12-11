# frozen_string_literal: true

module Types
  module Plan
    class MeasurementType < Types::BaseObject
      field :id, type: ID, null: false
      field :tracking_type, type: String, null: false
      field :tracking, type: ::Types::Plan::MeasurementTrackingSettingsType, null: true
    end
  end
end
