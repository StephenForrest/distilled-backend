# frozen_string_literal: true

module Mutations
  class CreateActionMutation < BaseAuthorizedMutation
    argument :plan_uuid, String, required: true
    argument :goal_id, String, required: true

    argument :name, String, required: true
    argument :description, String, required: true
    argument :start_date, String, required: true
    argument :end_date, String, required: true

    argument :tracking_settings, Types::Inputs::ActionTrackingInputType, required: true

    field :action, Types::Plan::ActionType, null: true

    # rubocop:disable Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength
    def resolve(plan_uuid:, goal_id:, name:, description:, start_date:, end_date:, tracking_settings:)
      plan = current_workspace.plans.find_by(uuid: plan_uuid)
      raise GraphQL::ExecutionError, 'No plan found' if plan.blank?

      goal = plan.goals.find(goal_id)
      raise GraphQL::ExecutionError, 'No goal found' if goal.blank?

      action = SuccessCriteria.transaction do
        success_criteria = create_success_critera(goal, name, description, start_date, end_date)
        tracking_type = tracking_settings.keys.first
        action = success_criteria.create_action!(tracking_settings[tracking_type], tracking_type)
        action
      end
      { action: }
    end
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength

    private

    def create_success_critera(goal, name, description, start_date, end_date)
      goal.success_criterias.create!(
        name:,
        description:,
        start_date:,
        end_date:,
        owner_id: current_user.id
      )
    end
  end
end
