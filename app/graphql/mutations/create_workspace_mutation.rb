# frozen_string_literal: true

module Mutations
  class CreateWorkspaceMutation < BaseMutation
    argument :title, String, required: true
    argument :auto_join_from_domain, Boolean, required: true

    field :workspace, type: Types::Workspace::WorkspaceType, null: false

    def resolve(title:, auto_join_from_domain:)
      raise GraphQL::ExecutionError, 'Authentication expired' if context[:current_user].nil?

      workspace = context[:current_user].workspaces.create!(
        title:,
        auto_join_from_domain:,
        domain: context[:current_user].user_domain
      )

      { workspace: }
    end
  end
end
