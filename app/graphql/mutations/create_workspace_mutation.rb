# frozen_string_literal: true

module Mutations
  class CreateWorkspaceMutation < BaseMutation
    argument :title, String, required: true
    argument :auto_join_from_domain, Boolean, required: true
    argument :stripe_product, String, required: false

    field :workspace, type: Types::Workspace::WorkspaceType, null: false

    def resolve(title:, auto_join_from_domain:)
      raise GraphQL::ExecutionError, 'Authentication expired' if context[:current_user].nil?

      workspace = context[:current_user].workspaces.create!(
        title: title,
        auto_join_from_domain: auto_join_from_domain,
        domain: context[:current_user].user_domain,
        stripe_product: stripe_product,
      )

      { workspace: workspace }
    end
  end
end
