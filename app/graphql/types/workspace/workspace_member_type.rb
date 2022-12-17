# frozen_string_literal: true

module Types
  module Workspace
    class WorkspaceMemberType < Types::BaseObject
      field :id, type: ID, null: false
      field :user, type: Types::User::UserType, null: false
      field :role, type: String, null: false
    end
  end
end
