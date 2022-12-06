# frozen_string_literal: true

# == Schema Information
#
# Table name: success_criterias
#
#  id                    :bigint           not null, primary key
#  description           :text             default("")
#  end_date              :datetime
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
class SuccessCriteria < ApplicationRecord
  belongs_to :goal
  has_many :actions, dependent: :destroy
  has_many :measurements, dependent: :destroy

  self.table_name = 'success_criterias'

  enum :success_criteria_type, {
    action: 0,
    measurement: 1
  }

  def owner
    goal.workspace.users.find(owner_id)
  end
end
