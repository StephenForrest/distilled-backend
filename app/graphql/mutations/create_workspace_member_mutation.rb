# frozen_string_literal: true

module Mutations
  class CreateWorkspaceMemberMutation < BaseAuthorizedMutation
    argument :email, String, required: true
    argument :name, String, required: true

    field :workspace_member, Types::Workspace::WorkspaceMemberType, null: false

    def resolve(email:, name:)
      user = create_or_find_user(email:, name:)
      workspace_member = current_workspace.workspace_members.find_by(user:)
      if workspace_member.present?
        raise GraphQL::ExecutionError, 'User is already part of your  workspace or have already been invited'
      end

      workspace_member = current_workspace.workspace_members.create!(
        user:
      )
      { workspace_member: }
    end

    def create_or_find_user(email:, name:)
      user = User.find_by(email:)

      return user if user.present?

      User.create!(
        email:,
        invite_status: 'invited',
        name:,
        password_encrypted: BCrypt::Engine.hash_secret(
          'test1234',
          Rails.application.credentials.config[:password_salt]
        )
      )
    end
  end
end
