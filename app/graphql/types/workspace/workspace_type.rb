# frozen_string_literal: true

module Types
  module Workspace
    class WorkspaceType < Types::BaseObject
      field :id, type: ID, null: false
      field :title, type: String, null: false
      field :domain, type: String, null: true
      field :auto_join_from_domain, type: Boolean, null: false
      field :personal_domain, type: Boolean, null: false
      field :api_key, type: String, null: false
      field :current_onboarding_step, type: String
      field :workspace_members, type: [Types::Workspace::WorkspaceMemberType], null: false

      def personal_domain
        object.public_domain?
      end

      def api_key
        context[:current_user].workspace_members.find_by(workspace_id: object.id)&.api_key
      end

      def current_onboarding_step
        ::Workspaces::OnboardingSteps.new(object).current&.camelize(:lower)
      end
    end
  end
end
