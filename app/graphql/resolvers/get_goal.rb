# frozen_string_literal: true

module Resolvers
  class GetGoal < BaseResolver
    # outputs
    type Types::Plan::GoalType, null: false
    argument :id, String, required: true

    def resolve(id: nil)
      context[:current_user].goals.find(id)
    end
  end
end
