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
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  goal_id               :bigint           not null
#  owner_id              :bigint           default(-1), not null
#
# Indexes
#
#  index_success_criterias_on_goal_id  (goal_id)
#
FactoryBot.define do
  factory :success_criteria do
    start_date { DateTime.now }
    end_date { DateTime.now + 10.days }
    goal { create(:goal) }
    owner_id { create(:user).id }

    trait :with_action do
      success_criteria_type { 'action' }
      after(:create) do |success_criteria, _evaluator|
        create :action, success_criteria:
      end
    end

    trait :with_measurement do
      success_criteria_type { 'measurement' }
      after(:create) do |success_criteria, _evaluator|
        create :measurement, success_criteria:
      end
    end
  end
end
