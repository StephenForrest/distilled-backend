# frozen_string_literal: true

module Mutations
  class CreateGoalMutation < BaseAuthorizedMutation
    argument :title, String, required: true
    argument :plan_uuid, String, required: true
    argument :expires_on, String, required: true

    field :goal, Types::Plan::GoalType, null: false

    def resolve(title:, plan_uuid:, expires_on:)
      stripe_product = current_user.stripe_product
    
      if stripe_product == "STRIPE_FREE_PLAN_ID"
        max_goals = 6
      elsif stripe_product == "STRIPE_PRO_PLAN_ID"
        max_goals = Float::INFINITY
      end
    
      if current_workspace.goals.count >= max_goals    
        return GraphQL::ExecutionError.new("You have reached the maximum number of goals allowed on the free plan")
      end

      puts current_workspace.stripe_product
      puts current_workspace.plans.count
      puts current_workspace.goals.count
      puts stripe_product
      puts max_goals
    
      goal = plan.goals.create!(
        title: title, 
        plan_id: plan.id, 
        expires_on: expires_on, 
        owner_id: current_user.id,
        workspace_id: current_workspace.id
      )
    
      { goal: goal }
    end    
  end
end
