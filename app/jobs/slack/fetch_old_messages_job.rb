# frozen_string_literal: true

module Slack
  class FetchOldMessagesJob < ApplicationJob
    def perform(slack_channel, measurement_slack)
      integration = measurement_slack.integration_slack
      integration.slack_get_request('conversations.join', channel: slack_channel.slack_channel_id)

      total = count_history(integration_slack: integration, slack_channel:)
      measurement_slack.increment_by(total)

      publish_websocket(measurement_slack)
    end

    def publish_websocket(slack)
      payload = {
        id: slack.measurement.success_criteria_id,
        completion: slack.completion
      }

      ::WebSockets::Publish.call(slack.workspace_id, :success_criteria_updated, payload)
    end

    def count_history(integration_slack:, slack_channel:, total: 0, cursor: nil)
      response = integration_slack.slack_get_request(
        'conversations.history',
        channel: slack_channel.slack_channel_id,
        cursor:
      )
      new_total = total + response['messages'].length
      if response['has_more']
        total + count_history(
          integration_slack:,
          slack_channel:,
          total: new_total,
          cursor: response['response_metadata']['next_cursor']
        )
      else
        new_total
      end
    end
  end
end
