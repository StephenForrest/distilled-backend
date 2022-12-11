# frozen_string_literal: true

# == Schema Information
#
# Table name: integrations_slack
#
#  id             :bigint           not null, primary key
#  scopes         :json             not null
#  team_name      :string           default(""), not null
#  token          :text             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#  team_id        :string           not null
#  workspace_id   :bigint           not null
#
# Indexes
#
#  index_integrations_slack_on_integration_id  (integration_id)
#  index_integrations_slack_on_workspace_id    (workspace_id)
#
module Integrations
  class Slack < ApplicationRecord
    belongs_to :integration, class_name: '::Integration'
    belongs_to :workspace

    SLACK_BASE_API = 'https://slack.com/api'

    self.table_name = 'integrations_slack'

    def self.fetch_token(code:, client_id:, client_secret:)
      HTTParty.post("#{SLACK_BASE_API}/oauth.v2.access", body: { code:, client_id:, client_secret: })
    end

    def channels
      @channels ||= fetch_paginated_conversations(channels: [], options: { limit: 200 })
    end

    def self.on_create!(settings, integration)
      s_settings = settings[:slack]
      create!(
        team_name: s_settings[:team_name],
        team_id: s_settings[:team_id],
        scopes: s_settings[:scopes],
        token: s_settings[:token],
        workspace: integration.workspace,
        integration:
      )
    end

    private

    def slack_get_request(endpoint, options)
      HTTParty.get("#{SLACK_BASE_API}/#{endpoint}",
                   { query: options, headers: { 'Authorization' => "Bearer #{token}" } })
    end

    def fetch_paginated_conversations(cursor: nil, channels: [], options: {})
      options[:cursor] = cursor if cursor.present?
      res = slack_get_request('conversations.list', options)
      return raise 'Something went wrong' unless res['ok']

      channels.concat(res['channels'].map { |channel| { name: channel['name'], id: channel['id'], num_members: 4 } })
      next_cursor = res['response_metadata']['next_cursor']
      return channels if next_cursor.blank?

      fetch_paginated_conversations(cursor: next_cursor, channels:, options:)
    end
  end
end
