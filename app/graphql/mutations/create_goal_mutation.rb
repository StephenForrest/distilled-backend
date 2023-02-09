# frozen_string_literal: true

module Mutations
  class CreateGoalMutation < BaseAuthorizedMutation
    argument :title, String, required: true
    argument :plan_uuid, String, required: true
    argument :expires_on, String, required: true

    field :goal, Types::Plan::GoalType, null: false

    def resolve(title:, plan_uuid:, expires_on:)
      plan = current_workspace.plans.find_by(uuid: plan_uuid)
      stripe_product = current_workspace.stripe_product
      max_goals = stripe_product == 'free' ? 6 : Float::INFINITY
    
      if plan.goals.count >= max_goals
        begin
          Intercom::Client.new.messages.create(
            from: { type: 'user', id: current_user.intercom_user_id },
            body: "Bummer! You've reached the maximum number of goals allowed on the free plan 🥺. Ready to upgrade?"
          )
        rescue => e
          Rails.logger.error("Intercom Error: #{e.inspect}")
        end
    
        raise GraphQL::ExecutionError, "You have reached the maximum number of goals allowed on the free plan"
      end
    
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
