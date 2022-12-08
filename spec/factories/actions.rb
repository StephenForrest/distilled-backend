# frozen_string_literal: true

# == Schema Information
#
# Table name: actions
#
#  id                  :bigint           not null, primary key
#  tracking_type       :integer          default("checklist"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  action_object_id    :integer          default(-1), not null
#  success_criteria_id :bigint           not null
#  workspace_id        :bigint           not null
#
# Indexes
#
#  index_actions_on_success_criteria_id  (success_criteria_id)
#  index_actions_on_workspace_id         (workspace_id)
#
FactoryBot.define do
  factory :action do
    tracking_type { 'checklist' }
    success_criteria { create(:success_criteria) }
    workspace_id { create(:workspace).id }

    trait :with_checklist do
      tracking_type { 'checklist' }
      after(:create) do |action, _evaluator|
        create(:checklist,
               action:,
               workspace_id: action.workspace_id,
               settings: { "checklist": [{ item: 'test', id: '123-123',
                                           due_date: DateTime.new.utc.to_s }] })
      end
    end
  end
end
