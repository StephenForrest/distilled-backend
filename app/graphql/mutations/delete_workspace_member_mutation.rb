# frozen_string_literal: true

module Mutations
  class DeleteWorkspaceMemberMutation < BaseAuthorizedMutation
    argument :email, String, required: true

    field :workspace_member, Types::Workspace::WorkspaceMemberType, null: false

    def resolve(email:)
      user = User.find_by(email:)
      workspace_member = current_workspace.workspace_members.find_by(user:)
      workspace_member.destroy
      { workspace_member: }
    end
  end
end
