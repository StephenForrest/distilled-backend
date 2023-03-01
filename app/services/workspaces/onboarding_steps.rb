# frozen_string_literal: true

module Workspaces
  class OnboardingSteps
    INFORMATION = 'information'

    ALL = [
      INFORMATION,
    ].freeze

    attr_reader :workspace

    def initialize(workspace)
      @workspace = workspace
    end

    def pass_onboarding_step(step_name)
      return if workspace.onboarding_steps[step_name]

      validate_onboarding_step_name(step_name)
      workspace.update!(onboarding_steps: workspace.onboarding_steps.merge(step_name => true))
    end

    def current
      ALL.find do |step|
        !workspace.onboarding_steps[step]
      end
    end

    private

    def validate_onboarding_step_name(name)
      return true if ALL.include?(name)

      raise "Invalid 'step_name' passed. Passed #{name.inspect}. " \
            "Should be one of #{ALL.inspect}"
    end
  end
end
