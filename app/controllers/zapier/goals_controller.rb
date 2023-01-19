# frozen_string_literal: true

module Zapier
  class GoalsController < BaseController
    def index
      goals = current_workspace.goals.map { |goal| [goal.id, goal.title] }
      render json: goals.to_h
    end
  end
end
