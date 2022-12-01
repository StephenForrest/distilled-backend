# frozen_string_literal: true

module Mutations
  class CreateGoalMutation < BaseAuthorizedMutation
    argument :title, String, required: true
    argument :plan_id, String, required: true

    field :goal, Types::Plan::GoalType, null: false

    def resolve(title:, plan_id:)
      plan = current_user.plans.find(plan_id)
      goal = plan.goals.create!(title:, plan_id:)
      { goal: }
    end
  end
end
