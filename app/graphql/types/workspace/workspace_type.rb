# frozen_string_literal: true

module Types
  module Workspace
    class WorkspaceType < Types::BaseObject
      field :id, type: ID, null: false
      field :title, type: String, null: false
      field :domain, type: String, null: true
      field :auto_join_from_domain, type: Boolean, null: false
      field :personal_domain, type: Boolean, null: false
      field :workspace_members, type: [Types::Workspace::WorkspaceMemberType], null: false

      def personal_domain
        object.public_domain?
      end
    end
  end
end
