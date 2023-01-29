# frozen_string_literal: true

module Mutations
  module Integrations
    module Slack
      class CreateSlackConnectMutation < BaseAuthorizedMutation
        FAKE_TEAM_ID = 'fake_team'
        SLACK_BASE_API = 'https://slack.com/api'
        argument :email, String, required: true
        argument :channel_name, String, required: true

        field :ok, Boolean, null: false

        def resolve(channel_name:, email:)
          id = create_or_find_channel(channel_name)
          invite_to_channel(id, email)
          { ok: true }
        end

        private

        def create_or_find_channel(channel_name)
          response = slack_post_request('conversations.create', name: channel_name)
          if response['ok']
            id = response['channel']['id']
            SlackChannel.create!(name: channel_name, slack_channel_id: id, slack_team_id: FAKE_TEAM_ID)
            return id
          end

          if response['ok'] == false && response['error'] == 'name_taken'
            SlackChannel.find_by(name: channel_name, slack_team_id: FAKE_TEAM_ID).slack_channel_id
          end

          Rails.logger.error("Channel can\'t be created. Response #{response}")
        end

        def invite_to_channel(id, email)
          slack_post_request('conversations.inviteShared', channel: id, emails: email)
        end

        def slack_post_request(endpoint, params)
          resp = HTTParty.get("#{SLACK_BASE_API}/#{endpoint}?#{params.to_query}",
                              { headers: { 'Authorization' => "Bearer #{ENV.fetch('SLACK_BOT_TOKEN')}" } })
          Rails.logger.info("Slack [#{endpoint}] params=#{params}, response=#{resp}")
          resp
        end
      end
    end
  end
end
