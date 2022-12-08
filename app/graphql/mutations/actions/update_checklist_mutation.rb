# frozen_string_literal: true

module Mutations
  module Actions
    class UpdateChecklistMutation < BaseAuthorizedMutation
      argument :id, String, required: true

      argument :item_id, String, required: true
      argument :checked, Boolean, required: true

      field :goal, Types::Plan::GoalType, null: false

      def resolve(id:, item_id:, checked:)
        checklist = current_workspace.checklists.find(id)
        raise GraphQL::ExecutionError, 'Checklist not found' if checklist.blank?

        new_settings = checklist.settings['checklist'].map do |s|
          s['checked'] = checked if s['id'] == item_id
          s
        end

        checklist.update!(settings: { checklist: new_settings })

        { goal: checklist.action.success_criteria.goal }
      end
    end
  end
end
