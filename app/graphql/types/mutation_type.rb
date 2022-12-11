# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Authentication
    field :create_auth, mutation: Mutations::CreateAuthMutation
    field :sign_out, mutation: Mutations::SignOutMutation
    field :sign_up, mutation: Mutations::SignUpMutation

    # Plans
    field :create_plan, mutation: Mutations::CreatePlanMutation

    # Goals
    field :create_goal, mutation: Mutations::CreateGoalMutation

    # success criteria
    field :create_success_criteria, mutation: Mutations::CreateSuccessCriteriaMutation
    field :update_success_criteria, mutation: Mutations::UpdateSuccessCriteriaMutation

    # actions
    field :update_checklist, mutation: Mutations::Actions::UpdateChecklistMutation
    field :update_milestone, mutation: Mutations::Actions::UpdateMilestoneMutation

    # integrations
    field :create_integration, mutation: Mutations::CreateIntegrationMutation

    # slack integration
    field :create_slack_integration, mutation: Mutations::Integrations::Slack::CreateSlackIntegrationMutation
  end
end
