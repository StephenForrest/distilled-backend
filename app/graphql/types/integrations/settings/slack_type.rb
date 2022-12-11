# frozen_string_literal: true

module Types
  module Integrations
    module Settings
      class SlackType < Types::BaseObject
        field :id, type: ID, null: false
        field :scopes, type: [String], null: true
        field :channels, type: GraphQL::Types::JSON, null: true
      end
    end
  end
end
