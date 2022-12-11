# frozen_string_literal: true

module Types
  module Inputs
    class IntegrationSettingsInputType < Types::BaseInputObject
      one_of
      argument :slack, Types::Inputs::Integrations::SlackInputType, required: false
    end
  end
end
