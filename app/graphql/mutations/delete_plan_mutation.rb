# frozen_string_literal: true

module Mutations
  class DeletePlanMutation < BaseAuthorizedMutation
    argument :id, String, required: true

    field :success, type: Boolean, null: false

    def resolve(id:)
      plan = current_workspace.plans.find_by(uuid: id)
      op = plan.destroy!
      { success: op }
    end
  end
end
