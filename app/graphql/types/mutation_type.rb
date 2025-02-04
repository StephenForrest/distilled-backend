# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Authentication
    field :create_auth, mutation: Mutations::CreateAuthMutation
    field :sign_out, mutation: Mutations::SignOutMutation
    field :sign_up, mutation: Mutations::SignUpMutation
    field :verify_email, mutation: Mutations::VerifyEmailMutation

    # User
    field :update_user, mutation: Mutations::UpdateUserMutation

    # Workspace
    field :create_workspace, mutation: Mutations::CreateWorkspaceMutation
    field :update_workspace, mutation: Mutations::UpdateWorkspaceMutation

    # Workspace member
    field :create_workspace_member, mutation: Mutations::CreateWorkspaceMemberMutation
    field :delete_workspace_member, mutation: Mutations::DeleteWorkspaceMemberMutation

    # Plans
    field :create_plan, mutation: Mutations::CreatePlanMutation
    field :update_plan, mutation: Mutations::UpdatePlanMutation
    field :delete_plan, mutation: Mutations::DeletePlanMutation

    # Goals
    field :create_goal, mutation: Mutations::CreateGoalMutation
    field :delete_goal, mutation: Mutations::DeleteGoalMutation
    field :update_goal, mutation: Mutations::UpdateGoalMutation

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
    field :create_slack_connect, mutation: Mutations::Integrations::Slack::CreateSlackConnectMutation

    field :pass_onboarding_step, mutation: Mutations::PassOnboardingStepMutation
  end
end
