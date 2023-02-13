# frozen_string_literal: true

module Mutations
  class CreatePlanMutation < BaseAuthorizedMutation
    argument :name, String, required: true

    field :plan, Types::Plan::PlanType, null: false

    def resolve(name:)
      stripe_product = current_workspace.stripe_product

      if stripe_product == STRIPE_FREE_PLAN_ID
        max_plans = 1 # 1 plan per workspace
      elseif stripe_product == STRIPE_PRO_PLAN_ID
        max_plans = Float::INFINITY # unlimited plans per workspace
      else
        max_plans = 0 # no plans allowed
      end

      puts current_workspace.stripe_product
      puts current_workspace.plans.count
      puts current_workspace.goals.count
      puts stripe_product
      puts max_plans

      if current_workspace.plans.count >= max_plans
        return GraphQL::ExecutionError.new("You have reached the maximum number of plans allowed on the free plan")
      end

      { plan: current_user.plans.create!(name: name, workspace: current_workspace) }
    end
  end
end
