# frozen_string_literal: true

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

module Measurements
  class SlackActionLog < ApplicationRecord
    belongs_to :measurements_slack,
               class_name: 'Measurements::Slack',
               foreign_key: 'measurements_slacks_id',
               inverse_of: :measurement_slack_action_logs

    self.table_name = 'measurement_slack_action_logs'
  end
end
