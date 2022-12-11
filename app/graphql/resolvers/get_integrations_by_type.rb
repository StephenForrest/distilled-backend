# frozen_string_literal: true

module Resolvers
  class GetIntegrationsByType < BaseResolver
    # outputs
    type [Types::Integrations::IntegrationType], null: false
    argument :integration_type, String, required: true

    def resolve(integration_type: nil)
      context[:current_workspace].integrations.where(integration_type:)
    end
  end
end
