# frozen_string_literal: true

task aggregate_slack_events: :environment do
  SlackEvent.aggregate_slack_events
end
