# frozen_string_literal: true

module Mutations
  class CreateSuccessCriteriaMutation < BaseAuthorizedMutation
    argument :goal_id, String, required: true
    argument :success_criteria_type, String, required: true

    argument :name, String, required: true
    argument :description, String, required: true
    argument :start_date, String, required: true
    argument :end_date, String, required: true

    argument :tracking_settings, Types::Inputs::ActionTrackingInputType, required: true

    field :success_criteria, Types::Plan::SuccessCriteriaType, null: true
    field :errors, GraphQL::Types::JSON, null: true

    # rubocop:disable Metrics/ParameterLists
    # rubocop:disable Metrics/AbcSize
    def resolve(goal_id:, success_criteria_type:, name:, description:, start_date:, end_date:, tracking_settings:)
      goal = current_workspace.goals.find(goal_id)
      raise GraphQL::ExecutionError, 'No goal found' if goal.blank?

      errors = ValidationErrors.new
      SuccessCriteria.run_validations(goal:, name:, start_date:, end_date:, errors:)

      if errors.blank?
        success_criteria = SuccessCriteria.transaction do
          success_criteria = create_success_criteria(success_criteria_type, goal, name, description, start_date,
                                                     end_date)
          tracking_type = tracking_settings.keys.first
          create_success_criteria_object(success_criteria, tracking_type, tracking_settings, errors)
          success_criteria.reload
        end
      end

      return { success_criteria: } if errors.blank?

      { errors: errors.serialize }
    end

    private

    def create_success_criteria_object(success_criteria, tracking_type, tracking_settings, errors)
      object = success_criteria.settings_class.create!(tracking_type:, workspace_id: current_workspace.id,
                                                       success_criteria:)
      object.validate_settings(tracking_settings, errors)
      raise ActiveRecord::Rollback if errors.present?

      object.create_settings!(tracking_settings)
    end

    def create_success_criteria(success_criteria_type, goal, name, description, start_date, end_date)
      goal.success_criterias.create!(
        name:,
        description:,
        start_date:,
        end_date:,
        owner_id: current_user.id,
        workspace_id: current_workspace.id,
        success_criteria_type:
      )
    end

    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Metrics/AbcSize
  end
end
