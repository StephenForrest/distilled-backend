# frozen_string_literal: true

module Types
  module Integrations
    class IntegrationSettingsType < Types::BaseUnion
      description 'Serialize settings of settings'
      possible_types Types::Integrations::Settings::SlackType

      def self.resolve_type(object, _context)
        raise GraphQL::ExecutionError, 'Invalid integration type' unless object.is_a?(::Integrations::Slack)

        Types::Integrations::Settings::SlackType
      end
    end
  end
end
