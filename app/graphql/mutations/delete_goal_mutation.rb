# frozen_string_literal: true

module Mutations
  class DeleteGoalMutation < BaseAuthorizedMutation
    argument :id, String, required: true

    field :success, type: Boolean, null: false

    def resolve(id:)
      goal = current_workspace.goals.find(id)
      op = goal.destroy!
      { success: op }
    end
  end
end
