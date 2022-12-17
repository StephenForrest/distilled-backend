# frozen_string_literal: true

module Mutations
  class UpdateWorkspaceMutation < BaseAuthorizedMutation
    argument :title, String, required: true
    argument :auto_join_from_domain, Boolean, required: true

    field :workspace, type: Types::Workspace::WorkspaceType, null: false

    def resolve(title:, auto_join_from_domain:)
      current_workspace.update!(title:, auto_join_from_domain:)
      { workspace: current_workspace.reload }
    end
  end
end
