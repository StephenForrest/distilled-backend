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
#
# Indexes
#
#  index_goals_on_plan_id  (plan_id)
#
class Goal < ApplicationRecord
  belongs_to :plan
  delegate :workspace, to: :plan, allow_nil: true

  enum :tracking_status, {
    ontrack: 0,
    atrisk: 1
  }

  def owner
    return nil if owner_id == -1

    workspace.users.find(owner_id)
  end
end
