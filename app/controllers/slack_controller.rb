# frozen_string_literal: true

class SlackController < ApplicationController
  def event
    if qualified_event?(params['team_id'], params['event'])
      SlackEvent.create!(
        team_id: params['team_id'],
        event_id: params['event_id'],
        event: params['event']
      )
    end
    render json: { "challenge": params['challenge'] }
  end

  def webhooks
    case params[:event][:type]
    when 'message'
      channel = SlackChannel.find_by(slack_team_id: params[:event][:team], slack_channel_id: params[:event][:channel])
      if channel
        channel.measurement_slacks.each do |slack|
          next unless slack.metric == 'new_messages'
          Measurements::SlackActionLog.create(measurements_slacks_id: slack.id, metric: slack.metric, value: 1)

          slack.increment!(:metric_value)
          # TODO: send data on FE
        end
      end
    else
      :noop
    end

    render json: :ok
  end

  def qualified_event?(team_id, event)
    qualified_team?(team_id) && (qualified_message_event?(event) || qualified_user_event?(event))
  end

  def qualified_team?(_team_id)
    ::Integrations::Slack.find_by(team_id: params['team_id']).present?
  end

  def qualified_message_event?(event)
    (event['type'] == 'message' && event['subtype'] == 'channel_join') ||
      (event['type'] == 'message' && event['subtype'].blank?)
  end

  def qualified_user_event?(event); end
end
