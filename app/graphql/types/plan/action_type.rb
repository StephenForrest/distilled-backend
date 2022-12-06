# frozen_string_literal: true

module Types
  module Plan
    class ActionType < Types::BaseObject
      field :id, type: ID, null: false
      field :tracking, type: ::Types::Plan::ActionTrackingSettingsType, null: true
    end
  end
end
