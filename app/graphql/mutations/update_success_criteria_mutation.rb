# frozen_string_literal: true

module Mutations
  class UpdateSuccessCriteriaMutation < BaseAuthorizedMutation
    argument :plan_uuid, String, required: true
    argument :goal_id, String, required: true
    argument :success_criteria_id, String, required: true

    argument :name, String, required: true
    argument :description, String, required: true
    argument :start_date, String, required: true
    argument :end_date, String, required: true

    argument :tracking_settings, Types::Inputs::ActionTrackingInputType, required: false

    field :success_criteria, type: Types::Plan::SuccessCriteriaType, null: true
    field :errors, GraphQL::Types::JSON, null: true

    # rubocop:disable Metrics/ParameterLists
    def resolve(plan_uuid:,
                goal_id:, success_criteria_id:,
                name:, description:, start_date:, end_date:,
                tracking_settings:)
      success_criteria, goal = get_success_criteria_and_goal(plan_uuid:, goal_id:, success_criteria_id:)

      errors = ValidationErrors.new
      SuccessCriteria.transaction do
        SuccessCriteria.run_validations(goal:, name:, start_date:, end_date:, errors:)
        if errors.blank?
          success_criteria.update!(name:, description:, start_date:, end_date:)
          success_criteria.validate_settings(tracking_settings, errors)
          raise ActiveRecord::Rollback if errors.present?

          success_criteria.update_settings!(tracking_settings)
        end
      end

      return { errors: errors.serialize } if errors.present?

      { success_criteria: }
    end
    # rubocop:enable Metrics/ParameterLists

    private

    def get_success_criteria_and_goal(plan_uuid:, goal_id:, success_criteria_id:)
      plan = current_workspace.plans.find_by(uuid: plan_uuid)
      raise GraphQL::ExecutionError, 'No plan found' if plan.blank?

      goal = plan.goals.find(goal_id)
      raise GraphQL::ExecutionError, 'No goal found' if goal.blank?

      success_criteria = goal.success_criterias.find(success_criteria_id)
      raise GraphQL::ExecutionError, 'No success criteria found' if success_criteria.blank?

      [success_criteria, goal]
    end
  end
end
