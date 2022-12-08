# frozen_string_literal: true

module Types
  module Plan
    class ActionTrackingSettingsType < Types::BaseUnion
      description 'Serialize settings of settings'
      possible_types Types::Plan::Actions::ChecklistType, Types::Plan::Actions::MilestoneType

      def self.resolve_type(object, _context)
        # rubocop:disable Style/CaseLikeIf
        if object.is_a?(Checklist)
          Types::Plan::Actions::ChecklistType
        elsif object.is_a?(Milestone)
          Types::Plan::Actions::MilestoneType
        else
          raise GraphQL::ExecutionError, 'Invalid action'
        end
        # rubocop:enable Style/CaseLikeIf
      end
    end
  end
end
