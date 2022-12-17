# frozen_string_literal: true

module Types
  module User
    class CurrentUserType < Types::BaseObject
      field :id, type: ID, null: false
      field :email, type: String, null: false
      field :name, type: String, null: true
      field :email_verified, type: Boolean, null: false
      field :workspaces, type: [Types::Workspace::WorkspaceType], null: false
    end
  end
end
