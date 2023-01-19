# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
#
#  id                  :bigint           not null, primary key
#  code                :string
#  tracking_status     :integer          default(0), not null
#  tracking_type       :integer          default("slack"), not null
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
  has_many :measurements_slacks, dependent: :destroy, class_name: 'Measurements::Slack'

  belongs_to :workspace

  enum :tracking_type, {
    slack: 0,
    manual: 1,
    zapier: 2
  }

  def tracking_class
    case tracking_type.to_sym
    when :slack
      Measurements::Slack
    # TODO (atanych): Looks like we can unifity measurements
    when :zapier
      Measurements::Slack
    else
      raise 'Invalid tracking type'
    end
  end
  

  def validate_settings(tracking_settings, errors)
    validation_errors = tracking_class.validate_settings(self, tracking_settings)
    return if validation_errors.blank?

    errors.add('tracking_settings', validation_errors)
  end

  def tracking
    tracking_class.where(measurement: self).first
  end

  delegate :completion, to: :tracking

  def create_settings!(tracking_settings)
    tracking_class.on_create!(measurement: self, settings: tracking_settings.as_json)
  end

  def update_settings!(tracking_settings)
    tracking.on_update!(settings: tracking_settings.as_json)
  end
end
