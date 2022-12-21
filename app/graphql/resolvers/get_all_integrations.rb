# frozen_string_literal: true

module Resolvers
  class GetAllIntegrations < BaseResolver
    # outputs
    type [Types::Integrations::IntegrationType], null: false

    def resolve
      context[:current_workspace].integrations
    end
  end
end
