# frozen_string_literal: true

module Types
  module Plan
    module Actions
      class ChecklistType < Types::BaseObject
        field :id, String, null: false
        field :settings, GraphQL::Types::JSON, null: false
      end
    end
  end
end
