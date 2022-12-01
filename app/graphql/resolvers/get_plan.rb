# frozen_string_literal: true

module Resolvers
  class GetPlan < BaseResolver
    # outputs
    type Types::Plan::PlanType, null: false
    argument :uuid, String, required: true

    def resolve(uuid: nil)
      context[:current_user].plans.find_by(uuid:)
    end
  end
end
