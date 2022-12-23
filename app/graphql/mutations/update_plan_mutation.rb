# frozen_string_literal: true

module Mutations
  class UpdatePlanMutation < BaseAuthorizedMutation
    argument :id, String, required: true
    argument :name, String, required: true

    field :plan, Types::Plan::PlanType, null: false

    def resolve(id:, name:)
      plan = current_workspace.plans.find_by(uuid: id)
      plan.update!(name:)
      { plan: }
    end
  end
end
