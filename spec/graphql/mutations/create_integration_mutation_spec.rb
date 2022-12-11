# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateIntegrationMutation, type: :graphql do
    let(:name) { 'Test integration' }
    let(:integration_type) { 'slack' }
    let(:integration_settings) do
      {
        slack: {
          token: 'sample-token',
          teamName: 'whatever',
          scopes: ['sample-scope'],
          teamId: 'team_id'
        }
      }
    end

    describe '.resolve' do
      let(:mutation) do
        <<~GQL
          mutation($name: String!, $integrationType: String!, $integrationSettings: IntegrationSettingsInput!) {
            createIntegration(name: $name, integrationType: $integrationType, integrationSettings: $integrationSettings) {
              integration {
                id
                name
                integrationType
              }
            }
          }
        GQL
      end

      subject do
        execute_graphql(
          mutation,
          { name:, integrationType: integration_type, integrationSettings: integration_settings },
          {
            current_user: user,
            current_workspace: workspace
          }
        )
      end

      context 'when invalid auth' do
        let(:user) { nil }
        let(:workspace) { nil }

        it 'throws error' do
          expect(subject['errors'].first['message']).to eq('Authentication expired')
        end
      end

      context 'with valid user and workspace' do
        let(:user) { create(:user_with_workspace) }
        let(:workspace) { user.workspaces.first }
        let(:name) { 'Test plan' }

        it 'creates an integration and a slack integration' do
          result = nil
          expect { result = subject }.to change { Integration.all.size }
            .by(1)
            .and change { ::Integrations::Slack.all.size }.by(1)
        end
      end
    end
  end
end
