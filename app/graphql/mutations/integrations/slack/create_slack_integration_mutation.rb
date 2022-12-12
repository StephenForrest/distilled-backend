# frozen_string_literal: true

module Mutations
  module Integrations
    module Slack
      class CreateSlackIntegrationMutation < BaseAuthorizedMutation
        argument :code, String, required: true

        field :integration, Types::Integrations::IntegrationType, null: true
        field :errors, String, null: true

        def resolve(code:)
          client_id = Rails.application.credentials.config[:slack_client_id]
          client_secret = Rails.application.credentials.config[:slack_client_secret]
          res = ::Integrations::Slack.fetch_token(code:, client_id:, client_secret:)
          return { errors: '' } unless res['ok']

          integration = create_integration(res)
          { integration: }
        end

        def create_integration(res) # rubocop:disable Metrics/AbcSize
          team_id = res['team']['id']
          team_name = res['team']['name']
          token = res['access_token']
          scopes = res['scope']

          existing_slack_integration = ::Integrations::Slack.find_by(team_id:, workspace: current_workspace)
          if existing_slack_integration.present?
            existing_slack_integration.update!(team_name:, token:, scopes:)
            existing_slack_integration.integration
          else
            integration = current_user.integrations.create!(name: team_name, integration_type: 'slack',
                                                            workspace: current_workspace)
            integration.settings_class.on_create!({ slack: { team_id:, team_name:, token:, scopes: } }, integration)
            integration
          end
        end
      end
    end
  end
end
