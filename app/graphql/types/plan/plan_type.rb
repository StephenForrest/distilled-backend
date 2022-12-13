# frozen_string_literal: true

module Types
  module Plan
    class PlanType < Types::BaseObject
      field :id, type: ID, null: false
      field :name, type: String, null: true
      field :uuid, type: String, null: false
      field :goals, type: [Types::Plan::GoalType], null: true
      field :goals_count, type: Integer, null: true
      field :recent_goals, type: [Types::Plan::GoalType], null: true

      def id
        object.uuid
      end

      def goals_count
        object.goals.size
      end

      def recent_goals
        object.goals.order(updated_at: :desc).limit(3)
      end
    end
  end
end
