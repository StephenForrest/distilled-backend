class AddOnboardingStepsToWorkspaces < ActiveRecord::Migration[7.0]
  def change
    add_column :workspaces, :onboarding_steps, :jsonb, null: false, default: {}
  end
end
