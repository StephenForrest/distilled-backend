# frozen_string_literal: true

module Mutations
  class PassOnboardingStepMutation < BaseAuthorizedMutation
    class StepNameEnum < Types::BaseEnum
      value 'SURVEY', value: ::Workspaces::OnboardingSteps::SURVEY
      value 'DEMO', value: ::Workspaces::OnboardingSteps::DEMO
      value 'SUBSCRIPTION', value: ::Workspaces::OnboardingSteps::SUBSCRIPTION
    end

    argument :name, StepNameEnum, required: true

    field :workspaces, Types::Workspace::WorkspaceType, null: false

    def resolve(name:)
      ::Workspaces::OnboardingSteps.new(current_workspace).pass_onboarding_step(name)
      { workspaces: current_workspace }
    end
  end
end
