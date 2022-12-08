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

  enum tracking_type: {
    checklist: 0,
    milestone: 1
  }

  def validate_settings(tracking_settings, errors)
    raise 'unknown tracking type' unless tracking_type.to_sym == :checklist

    validation_errors = Checklist.validate_settings(self, tracking_settings[:checklist])
    return if validation_errors.blank?

    errors.add('tracking_settings', validation_errors)
  end

  def tracking
    raise 'unknown tracking type' unless tracking_type.to_sym == :checklist

    checklists.first
  end

  delegate :completion, to: :tracking

  def create_settings!(tracking_settings)
    raise "Unknown tracking type: #{tracking_type}" unless tracking_type.to_sym == :checklist

    checklists.create!(settings: tracking_settings.as_json, workspace:)
  end

  def update_settings!(tracking_settings)
    raise 'unknown tracking type' unless tracking_type.to_sym == :checklist

    checklists.first.update!(settings: tracking_settings.as_json)
  end
end
