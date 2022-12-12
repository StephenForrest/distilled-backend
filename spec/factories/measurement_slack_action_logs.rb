# == Schema Information
#
# Table name: measurement_slack_action_logs
#
#  id                     :bigint           not null, primary key
#  metric                 :integer          default(0), not null
#  value                  :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  measurements_slacks_id :bigint           not null
#
# Indexes
#
#  index_measurement_slack_action_logs_on_measurements_slacks_id  (measurements_slacks_id)
#
FactoryBot.define do
  factory :measurement_slack_action_log do
    
  end
end
