# frozen_string_literal: true

module Resolvers
  class GetWorkspaceDetails < BaseResolver
    # outputs
    type Types::Workspace::WorkspaceType, null: false

    def resolve
      current_workspace
    end
  end
end
