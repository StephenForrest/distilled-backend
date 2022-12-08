# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
#
#  id                  :bigint           not null, primary key
#  measurement_type    :integer          default("manual"), not null
#  tracking_status     :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  success_criteria_id :bigint           not null
#  workspace_id        :bigint           not null
#
# Indexes
#
#  index_measurements_on_success_criteria_id  (success_criteria_id)
#  index_measurements_on_workspace_id         (workspace_id)
#
class Measurement < ApplicationRecord
  belongs_to :success_criteria

  enum :measurement_type, {
    manual: 0
  }
end
