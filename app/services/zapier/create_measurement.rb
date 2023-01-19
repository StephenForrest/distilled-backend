# frozen_string_literal: true

module Zapier
  class CreateMeasurement
    include CallableService

    def initialize(params, workspace_member, code)
      @params = params
      @workspace_member = workspace_member
      @code = code
    end

    def call
      SuccessCriteria.transaction do
        success_criteria = Mutations::CreateSuccessCriteriaMutation.create_success_criteria(
          workspace_member.user, workspace_member.workspace,
          :measurement, goal, params[:name], params[:description], params[:start_date],
          params[:end_date]
        )

        object = success_criteria.settings_class.create!(
          tracking_type: :zapier, workspace_id: workspace_member.workspace.id, success_criteria:
        )

        settings = {
          'slack' => {
            'integration_id' => nil,
            'metric' => :zapier_metric,
            'value' => params[:target_value],
            'channel_filters' => []
          }
        }
        zapier = Measurements::Slack.on_create!(measurement: success_criteria.measurement, settings:)
        zapier.measurement.update!(code: code)
        zapier.measurement
      end
    end

    private

    attr_reader :params, :workspace_member, :code

    def goal
      workspace_member.workspace.goals.find(params[:goal])
    end
  end
end
