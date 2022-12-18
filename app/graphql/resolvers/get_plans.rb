# frozen_string_literal: true

module Resolvers
  class GetPlans < BaseResolver
    # outputs
    type [Types::Plan::PlanType], null: false

    def resolve
      current_workspace.plans
    end
  end
end
