# frozen_string_literal: true

module Mutations
  class PassOnboardingStepMutation < BaseAuthorizedMutation
    class StepNameEnum < Types::BaseEnum
      value 'INFORMATION', value: ::Workspaces::OnboardingSteps::INFORMATION
    end

    argument :name, StepNameEnum, required: true

    field :workspace, Types::Workspace::WorkspaceType, null: false

    def resolve(name:)
      ::Workspaces::OnboardingSteps.new(current_workspace).pass_onboarding_step(name)
      { workspace: current_workspace }
    end
  end
end