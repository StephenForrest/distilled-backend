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
      field :success_criteria_type, type: String, null: false
      field :action, type: Types::Plan::ActionType, null: true
    end
  end
end
