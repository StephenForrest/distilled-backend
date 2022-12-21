# frozen_string_literal: true

module Resolvers
  class GetActionSuccessCriterias < BaseResolver
    # outputs
    type [Types::Plan::SuccessCriteriaType], null: false

    def resolve
      context[:current_workspace].success_criterias.where(success_criteria_type: 'action')
    end
  end
end
