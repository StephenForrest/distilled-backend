# frozen_string_literal: true

module Types
  module Plan
    class PlanType < Types::BaseObject
      field :id, type: ID, null: false
      field :name, type: String, null: true
      field :uuid, type: String, null: false
    end
  end
end
