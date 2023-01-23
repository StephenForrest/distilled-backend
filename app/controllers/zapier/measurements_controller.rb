# frozen_string_literal: true

module Zapier
  class MeasurementsController < BaseController
    def create
      if params[:meta][:isLoadingSample]
        render json: { status: :ok, test_call: true }
        return
      end
      link = params[:meta][:zap][:link]
      Rails.logger.info("Code #{link}")
      measurement = Measurement.find_by(code: link) || Zapier::CreateMeasurement.call(
        params[:inputData], current_workspace_member, link
      )

      zapier = measurement.tracking

      zapier.increment_by(1)

      payload = {
        id: zapier.measurement.success_criteria_id,
        completion: zapier.completion
      }

      ::WebSockets::Publish.call(zapier.workspace_id, :success_criteria_updated, payload)

      render json: { status: :ok }
    end
  end
end
