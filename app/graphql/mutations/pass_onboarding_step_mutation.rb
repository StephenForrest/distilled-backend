# frozen_string_literal: true

module Mutations
  class PassOnboardingStepMutation < BaseAuthorizedMutation
    class StepNameEnum < Types::BaseEnum
      value 'SURVEY', value: ::Workspaces::OnboardingSteps::SURVEY
      value 'DEMO', value: ::Workspaces::OnboardingSteps::DEMO
      value 'SUBSCRIPTION', value: ::Workspaces::OnboardingSteps::SUBSCRIPTION
      value 'CALENDLY', value: ::Workspaces::OnboardingSteps::CALENDLY
    end

    argument :name, StepNameEnum, required: true

    field :workspace, Types::Workspace::WorkspaceType, null: false

    def resolve(name:)
      ::Workspaces::OnboardingSteps.new(current_workspace).pass_onboarding_step(name)
      { workspace: current_workspace }
    end
  end
end
