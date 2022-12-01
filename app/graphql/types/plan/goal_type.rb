# frozen_string_literal: true

module Types
  module Plan
    class GoalType < Types::BaseObject
      field :id, type: ID, null: false
      field :title, type: String, null: true
    end
  end
end
