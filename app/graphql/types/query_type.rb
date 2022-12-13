# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :current_user, type: Types::User::CurrentUserType, null: false
    field :get_plan, resolver: Resolvers::GetPlan
    field :get_plans, resolver: Resolvers::GetPlans
    field :get_goal, resolver: Resolvers::GetGoal

    # integrations
    field :get_integrations_by_type, resolver: Resolvers::GetIntegrationsByType
    field :get_integration, resolver: Resolvers::GetIntegration

    # measurements
    field :get_slack_action_logs, resolver: Resolvers::GetSlackActionLogs

    def current_user
      user = context[:current_user]
      raise GraphQL::ExecutionError, 'Authentication expired' if user.nil?

      user
    end
  end
end
