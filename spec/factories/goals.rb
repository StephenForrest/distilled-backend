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
FactoryBot.define do
  factory :goal do
    title { 'Example Goal' }
    expires_on { DateTime.now.utc }
    progress { 10 }
    tracking_status { 'ontrack' }
    owner_id { create(:user).id }
    plan_id { create(:plan).id }
    workspace_id { create(:workspace).id }
  end
end
