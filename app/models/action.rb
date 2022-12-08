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
class Action < ApplicationRecord
  belongs_to :success_criteria
  belongs_to :workspace
  has_many :checklists, dependent: :destroy
  has_many :milestones, dependent: :destroy

  enum tracking_type: {
    checklist: 0,
    milestone: 1
  }

  def validate_settings(tracking_settings, errors)
    validation_errors = case tracking_type.to_sym
                        when :milestone
                          Milestone.validate_settings(self, tracking_settings[:milestone])
                        when :checklist
                          Checklist.validate_settings(self, tracking_settings[:checklist])
                        else
                          raise 'unknown tracking type'
                        end
    return if validation_errors.blank?

    errors.add('tracking_settings', validation_errors)
  end

  def tracking
    case tracking_type.to_sym
    when :milestone
      milestones.first
    when :checklist
      checklists.first
    else
      raise 'unknown tracking type'
    end
  end

  delegate :completion, to: :tracking

  def create_settings!(tracking_settings)
    case tracking_type.to_sym
    when :milestone
      milestones.create!(settings: tracking_settings.as_json, workspace:)
    when :checklist
      checklists.create!(settings: tracking_settings.as_json, workspace:)
    else
      raise 'unknown tracking type'
    end
  end

  def update_settings!(tracking_settings)
    tracking.update!(settings: tracking_settings.as_json)
  end
end
