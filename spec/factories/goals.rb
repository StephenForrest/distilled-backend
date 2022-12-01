# frozen_string_literal: true

# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  title      :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#
# Indexes
#
#  index_goals_on_plan_id  (plan_id)
#
FactoryBot.define do
  factory :goals do
  end
end
