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

    # Create Action
    field :create_action, mutation: Mutations::CreateActionMutation
  end
end
