# frozen_string_literal: true

module Mutations
  class CreatePlanMutation < BaseAuthorizedMutation
    argument :name, String, required: true

    field :plan, Types::Plan::PlanType, null: false

    def resolve(name:)
      { plan: current_user.plans.create!(name:, workspace: current_workspace) }
    end
  end
end
