# frozen_string_literal: true

module Mutations
  class UpdateGoalMutation < BaseAuthorizedMutation
    argument :id, String, required: true
    argument :title, String, required: true

    field :goal, Types::Plan::GoalType, null: false

    def resolve(id:, title:)
      goal = current_workspace.goals.find(id)
      goal.update!(title:)
      { goal: }
    end
  end
end
