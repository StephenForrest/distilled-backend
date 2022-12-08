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
FactoryBot.define do
  factory :checklist do
    workspace_id { create(:workspace).id }
  end
end
