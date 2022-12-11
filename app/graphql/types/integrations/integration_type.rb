# frozen_string_literal: true

module Types
  module Integrations
    class IntegrationType < Types::BaseObject
      field :id, type: ID, null: false
      field :name, type: String, null: false
      field :integration_type, type: String, null: false
      field :settings, type: Types::Integrations::IntegrationSettingsType, null: true
    end
  end
end
