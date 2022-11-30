# frozen_string_literal: true

# == Schema Information
#
# Table name: workspace_members
#
#  id           :bigint           not null, primary key
#  role         :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  workspace_id :bigint           not null
#
# Indexes
#
#  index_workspace_members_on_user_id       (user_id)
#  index_workspace_members_on_workspace_id  (workspace_id)
#
FactoryBot.define do
  factory :workspace_member do
    workspace { FactoryBot.create(:workspace) }
    user { FactoryBot.create(:user) }
  end
end
