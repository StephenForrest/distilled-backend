# frozen_string_literal: true

module Mutations
  class CreateGoalMutation < BaseAuthorizedMutation
    argument :title, String, required: true
    argument :plan_uuid, String, required: true
    argument :expires_on, String, required: true

    field :goal, Types::Plan::GoalType, null: false

    def resolve(title:, plan_uuid:, expires_on:)
      plan = current_user.plans.find_by(uuid: plan_uuid)
      goal = plan.goals.create!(title:, plan_id: plan.id, expires_on:, owner_id: current_user.id)
      { goal: }
    end
  end
end
