# frozen_string_literal: true

module Types
  module Plan
    class GoalType < Types::BaseObject
      field :id, type: ID, null: false
      field :title, type: String, null: true
      field :expires_on, type: String, null: true
      field :owner, type: Types::User::CurrentUserType, null: true
      field :tracking_status, type: String, null: false
      field :progress, type: Integer, null: false
      field :created_at, type: String, null: false
    end
  end
end
