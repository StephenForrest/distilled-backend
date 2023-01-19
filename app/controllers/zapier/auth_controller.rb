# frozen_string_literal: true

module Zapier
  class AuthController < BaseController
    def execute
      return render json: "API key is invalid", status: :unauthorized unless current_workspace

      render json: { name: "#{current_user.email} for #{current_workspace.title}" }
    end
  end
end
