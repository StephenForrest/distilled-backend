# frozen_string_literal: true

module Mutations
  class CreatePlanMutation < BaseAuthorizedMutation
    argument :name, String, required: true

    field :plan, Types::Plan::PlanType, null: false

    def resolve(name:)
      stripe_product = current_workspace.stripe_product

      if stripe_product == "STRIPE_FREE_PLAN_ID"
        max_plans = 1
      else
        max_plans = Float::INFINITY
      end

      if current_workspace.plans.count >= max_plans
        return GraphQL::ExecutionError.new("You have reached the maximum number of plans allowed on the free plan")
      end

      { plan: current_user.plans.create!(name: name, workspace: current_workspace) }
    end
  end
end
