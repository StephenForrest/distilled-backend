# frozen_string_literal: true

# == Schema Information
#
# Table name: checklists
#
#  id           :bigint           not null, primary key
#  settings     :json
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  action_id    :bigint           not null
#  workspace_id :bigint           not null
#
# Indexes
#
#  index_checklists_on_action_id     (action_id)
#  index_checklists_on_workspace_id  (workspace_id)
#
require 'rails_helper'

RSpec.describe Checklist, type: :model do
  let(:user) { create(:user_with_workspace) }
  let(:workspace) { user.workspaces.first }
  let(:plan) { create(:plan, user:, workspace:) }
  let(:success_criteria) { create(:success_criteria, workspace_id: workspace.id) }
  let(:action) { create(:action, success_criteria_id: success_criteria.id, workspace:) }
  let(:settings) do
    {
      checklist: [{
        id: 'id', item: 'test', dueDate: DateTime.now.utc.to_s, checked: false
      }]
    }
  end
  let(:checklist) { create(:checklist, workspace:, settings:, action:) }

  describe '#completion' do
    subject { checklist.completion }

    context 'when no items are checked' do
      it { is_expected.to eq 0 }
    end

    context 'when few items are checked' do
      let(:settings) do
        {
          checklist: [{
            id: 'id', item: 'test', dueDate: DateTime.now.utc.to_s, checked: false
          }, {
            id: 'id-1', item: 'test', dueDate: DateTime.now.utc.to_s, checked: true
          }, {
            id: 'id-2', item: 'test', dueDate: DateTime.now.utc.to_s, checked: true
          }, {
            id: 'id-3', item: 'test', dueDate: DateTime.now.utc.to_s, checked: false
          }]
        }
      end

      it { is_expected.to eq 0.5 }
    end
  end
end
