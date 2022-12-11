# frozen_string_literal: true

module Resolvers
  class GetIntegration < BaseResolver
    # outputs
    type Types::Integrations::IntegrationType, null: false
    argument :id, String, required: true

    def resolve(id:)
      current_workspace.integrations.find(id)
    end
  end
end
