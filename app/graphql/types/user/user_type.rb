# frozen_string_literal: true

module Types
  module User
    class UserType < Types::BaseObject
      field :id, type: ID, null: false
      field :email, type: String, null: false
      field :name, type: String, null: true
    end
  end
end
