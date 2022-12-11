# frozen_string_literal: true

module Types
  module Plan
    class SuccessCriteriaType < Types::BaseObject
      field :id, type: ID, null: false
      field :name, type: String, null: true
      field :description, type: String, null: true
      field :end_date, type: String, null: true
      field :start_date, type: String, null: true
      field :success_criteria_type, type: String, null: false
      field :owner, type: Types::User::CurrentUserType, null: true
      field :action, type: Types::Plan::ActionType, null: true
      field :measurement, type: Types::Plan::MeasurementType, null: true
      field :goal_id, type: String, null: true
      field :completion, type: Float, null: false
    end
  end
end
