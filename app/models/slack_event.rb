# frozen_string_literal: true

# == Schema Information
#
# Table name: slack_events
#
#  id         :bigint           not null, primary key
#  event      :json             not null
#  tracked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :string           not null
#  team_id    :string           not null
#
# Indexes
#
#  index_slack_events_on_event_id  (event_id)
#  index_slack_events_on_team_id   (team_id)
#

class SlackEvent < ApplicationRecord
  # rubocop:disable Metrics/AbcSize
  def self.aggregate_slack_events
    team_ids = Integrations::Slack.select(:team_id).distinct.map(&:team_id)
    measurement_increments = {}
    team_ids.each do |team_id|
      SlackEvent.where(team_id:, tracked: false).find_each(batch_size: 1_000) do |event|
        slack_integrations = Integrations::Slack.where(team_id: event.team_id)
        slack_integrations.map do |slack_integration|
          integration = slack_integration.integration
          measurements = Measurements::Slack.where(integrations_slack_id: integration.id)
          measurements.each do |_s_measurement|
            SlackEvent.qualify_event_for_slack_integration(event, slack_integration, measurement_increments)
          end

          event.update!(tracked: true)
        end
      end
      # rubocop:enable Metrics/AbcSize
    end
    update_measurements(measurement_increments)
  end

  def self.qualify_event_for_slack_integration(event, slack_integration, measurement_increments)
    integration = slack_integration.integration
    measurements = Measurements::Slack.where(integrations_slack_id: integration.id)
    measurements.each do |s_measurement, i|
      success_criteria = s_measurement.measurement.success_criteria
      next unless add_event_to_measurement(s_measurement, event)
      next unless success_criteria.start_date <= event.created_at && success_criteria.end_date >= event.created_at

      increment_measurement(measurement_increments, s_measurement)
    end
  end

  def self.increment_measurement(measurement_increments, s_measurement)
    measurement_increments[s_measurement.id] = if measurement_increments[s_measurement.id]
                                                 measurement_increments[s_measurement.id] + 1
                                               else
                                                 1
                                               end
  end

  def self.update_measurements(measurement_increments)
    measurement_increments.each do |key, value|
      Measurements::Slack.find(key).increment_by(value)
    end
  end

  def self.add_event_to_measurement(s_measurement, slack_event)
    return false unless slack_event.internal_event_type == 'new_message' && s_measurement.metric.to_s == 'new_messages'

    # return true if s_measurement.channel_filters.blank?

    # return false unless measurement.channel_filters.include?(slack_event.event['channel'])

    true
  end

  def internal_event_type
    return unless event['type'] == 'message' && event['subtype'].blank?

    'new_message'
  end
end
