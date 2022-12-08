# frozen_string_literal: true

# == Schema Information
#
# Table name: goals
#
#  id              :bigint           not null, primary key
#  expires_on      :datetime
#  progress        :integer          default(0), not null
#  title           :string           default(""), not null
#  tracking_status :integer          default("ontrack"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  owner_id        :bigint           default(-1), not null
#  plan_id         :bigint           not null
#  workspace_id    :bigint           not null
#
# Indexes
#
#  index_goals_on_plan_id       (plan_id)
#  index_goals_on_workspace_id  (workspace_id)
#
require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { create(:user_with_workspace) }
  let(:workspace) { user.workspaces.first }
  let(:plan) { create(:plan, user:, workspace:) }
  let(:goal) { create(:goal, owner_id: user.id, plan:) }

  it 'tests associations' do
    expect(goal.owner).to eq(user)
    expect(goal.workspace).to eq(workspace)
  end

  context 'with success_criterias' do
    let!(:success_criteria1) { create(:success_criteria, :with_action, goal:) }
    let!(:success_criteria2) { create(:success_criteria, :with_measurement, goal:) }

    it 'tests associations' do
      expect(goal.success_criterias.size).to eq(2)
      expect(goal.actions_count).to eq(1)
      expect(goal.measurements_count).to eq(1)
    end
  end
end
