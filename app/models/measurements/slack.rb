# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements_slack
#
#  id                    :bigint           not null, primary key
#  metric                :integer          default(0), not null
#  value                 :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  integrations_slack_id :bigint           not null
#  measurement_id        :bigint           not null
#  workspace_id          :bigint           not null
#
# Indexes
#
#  index_measurements_slack_on_integrations_slack_id  (integrations_slack_id)
#  index_measurements_slack_on_measurement_id         (measurement_id)
#  index_measurements_slack_on_workspace_id           (workspace_id)
#
module Measurements
  class Slack < ApplicationRecord
    belongs_to :workspace
    belongs_to :measurement

    self.table_name = 'measurements_slack'

    enum metric: {
      'new_users': 0,
      'all_users': 1,
      'user_churns': 2,
      'new_messages': 3,
      'all_messages': 4,
      'new_invites': 5,
      'all_invites': 6

    }

    def completion
      0.23
    end

    def integration_id
      integrations_slack_id
    end

    def self.on_create!(measurement:, settings:)
      create!(
        measurement:,
        workspace_id: measurement.workspace.id,
        integrations_slack_id: settings['slack']['integration_id'],
        metric: settings['slack']['metric'],
        value: settings['slack']['value']
      )
    end

    def self.validate_settings(_measurement, tracking_settings)
      errors = ValidationErrors.new
      settings = tracking_settings[:slack]
      if settings[:integration_id].blank? || Integration.find(settings[:integration_id]).blank?
        errors.add('integration_id',
                   'Choose an integration')
      end
      errors.add('metric', 'Required field') if settings[:metric].blank?
      errors.add('value', 'Required field') if settings[:value].blank?

      errors
    end
  end
end
