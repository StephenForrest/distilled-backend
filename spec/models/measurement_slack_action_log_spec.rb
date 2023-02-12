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
 require 'rails_helper'
 require_relative '../../app/graphql/types/plan/measurements/measurement_slack_action_logs_type'

 RSpec.describe MeasurementSlackActionLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
 end
