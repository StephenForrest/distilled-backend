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
