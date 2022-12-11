# frozen_string_literal: true

module Mutations
  class CreateIntegrationMutation < BaseAuthorizedMutation
    argument :name, String, required: true
    argument :integration_type, String, required: true
    argument :integration_settings, Types::Inputs::IntegrationSettingsInputType, required: true

    field :integration, Types::Integrations::IntegrationType, null: false

    def resolve(name:, integration_type:, integration_settings:)
      integration = current_user.integrations.create!(name:, integration_type:, workspace: current_workspace)
      integration.settings_class.on_create!(integration_settings, integration)

      { intergation: integration }
    end
  end
end
