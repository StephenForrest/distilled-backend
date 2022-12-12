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
#  tracking_status       :integer          default("ontrack"), not null
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
class SuccessCriteria < ApplicationRecord
  belongs_to :goal
  belongs_to :workspace
  has_many :actions, dependent: :destroy
  has_many :measurements, dependent: :destroy

  self.table_name = 'success_criterias'

  enum :success_criteria_type, {
    action: 0,
    measurement: 1
  }

  enum :tracking_status, {
    ontrack: 0,
    atrisk: 1,
    completed: 2
  }

  def settings_class
    case success_criteria_type.to_s
    when 'action'
      Action
    when 'measurement'
      Measurement
    else
      raise 'Not implemented'
    end
  end

  def settings_object
    case success_criteria_type.to_s
    when 'action'
      action
    when 'measurement'
      measurement
    else
      raise 'Not implemented'
    end
  end

  delegate :completion, to: :settings_object

  def owner
    goal.workspace.users.find(owner_id)
  end

  def action
    actions.first
  end

  def measurement
    measurements.first
  end

  def self.run_validations(goal:, name:, start_date:, end_date:, errors:)
    errors.add('name', 'Please add a name') if name.blank?
    validate_dates(goal, start_date, end_date, errors)
    errors
  end

  def self.validate_dates(goal, start_date_str, end_date_str, errors)
    start_date = DateTime.parse(start_date_str).utc
    end_date = DateTime.parse(end_date_str).utc
    goal_end_date = goal.expires_on.utc
    errors.add('end_date', 'End date cannot be later than start date') if end_date < start_date
    return unless end_date > goal_end_date

    errors.add('end_date', 'End date cannot be later than goal end date')
  end

  def validate_settings(tracking_settings, errors)
    case success_criteria_type.to_s
    when 'action'
      action.validate_settings(tracking_settings, errors)
    when 'measurement'
      measurement.validate_settings(tracking_settings, errors)
    else
      raise 'Not implemented'
    end
  end

  delegate :update_settings!, to: :settings_object

  def create_action!(tracking_settings, tracking_type)
    action = actions.create!(
      tracking_type:,
      workspace:
    )
    action.create_settings!(tracking_settings)
  end
end
