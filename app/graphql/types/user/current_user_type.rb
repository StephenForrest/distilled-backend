# frozen_string_literal: true

module Types
  module User
    class CurrentUserType < Types::BaseObject
      field :id, type: ID, null: false
      field :email, type: String, null: false
      field :first_name, type: String, null: true
      field :last_name, type: String, null: true
      field :position, type: String, null: true
      field :company, type: String, null: true
      field :email_verified, type: Boolean, null: false
      field :profile_pic, type: String, null: true
      field :workspaces, type: [Types::Workspace::WorkspaceType], null: false
    end
  end
end
