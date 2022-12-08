# frozen_string_literal: true

# == Schema Information
#
# Table name: success_criterias
#
#  id                    :bigint           not null, primary key
#  description           :text             default("")
#  end_date              :datetime
#  name                  :string           default(""), not null
#  start_date            :datetime
#  success_criteria_type :integer          default("action"), not null
#  tracking_status       :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  goal_id               :bigint           not null
#  owner_id              :bigint           default(-1), not null
#  workspace_id          :bigint           not null
#
# Indexes
#
#  index_success_criterias_on_goal_id       (goal_id)
#  index_success_criterias_on_workspace_id  (workspace_id)
#
FactoryBot.define do
  factory :success_criteria do
    start_date { DateTime.now }
    end_date { DateTime.now + 10.days }
    goal { create(:goal) }
    owner_id { create(:user).id }
    workspace_id { create(:workspace).id }

    trait :with_action do
      success_criteria_type { 'action' }
      after(:create) do |success_criteria, _evaluator|
        create :action, success_criteria:, workspace_id: success_criteria.workspace_id
      end
    end

    trait :with_checklist_action do
      success_criteria_type { 'action' }
      after(:create) do |success_criteria, _evaluator|
        create(:action, :with_checklist, success_criteria:, workspace_id: success_criteria.workspace_id)
      end
    end

    trait :with_measurement do
      success_criteria_type { 'measurement' }
      after(:create) do |success_criteria, _evaluator|
        create :measurement, success_criteria:, workspace_id: success_criteria.workspace_id
      end
    end
  end
end
