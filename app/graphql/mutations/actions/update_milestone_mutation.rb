# frozen_string_literal: true

module Mutations
  module Actions
    class UpdateMilestoneMutation < BaseAuthorizedMutation
      argument :id, String, required: true

      argument :item_id, String, required: true
      argument :checked, Boolean, required: true

      field :goal, Types::Plan::GoalType, null: false

      def resolve(id:, item_id:, checked:)
        milestone = current_workspace.milestones.find(id)
        raise GraphQL::ExecutionError, 'Milestone not found' if milestone.blank?

        new_settings = milestone.settings['milestone'].map do |s|
          s['checked'] = checked if s['id'] == item_id
          s
        end

        milestone.update!(settings: { milestone: new_settings })

        { goal: milestone.action.success_criteria.goal }
      end
    end
  end
end
