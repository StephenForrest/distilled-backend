# frozen_string_literal: true

# == Schema Information
#
# Table name: plans
#
#  id           :bigint           not null, primary key
#  name         :string           default(""), not null
#  uuid         :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  workspace_id :bigint           not null
#
# Indexes
#
#  index_plans_on_user_id       (user_id)
#  index_plans_on_workspace_id  (workspace_id)
#
FactoryBot.define do
  factory :plan do
    name { 'test plan' }
    workspace { FactoryBot.create(:workspace) }
    user { FactoryBot.create(:user) }
    uuid { SecureRandom.uuid }
  end
end
