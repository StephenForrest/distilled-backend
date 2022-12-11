# frozen_string_literal: true

module Types
  module Plan
    module Measurements
      class MeasurementSlackType < Types::BaseObject
        field :id, String, null: false
        field :integration_id, String, null: false
        field :metric, String, null: false
        field :value, Int, null: false
      end
    end
  end
end
