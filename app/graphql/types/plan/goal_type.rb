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
      field :actions_count, type: Integer, null: false
      field :measurements_count, type: Integer, null: false
      field :success_criterias, type: [Types::Plan::SuccessCriteriaType], null: true
      field :completion, type: Float, null: false
      field :success_criterias_count, type: Integer, null: true

      def success_criterias_count
        object.success_criterias.size
      end

      def recent_success_criterias
        object.success_criterias.order(updated_at: :desc).limit(3)
      end
    end
  end
end
