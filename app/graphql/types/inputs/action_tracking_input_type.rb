# frozen_string_literal: true

module Types
  module Inputs
    class ActionTrackingInputType < Types::BaseInputObject
      one_of
      # Actions
      argument :milestone, [Types::Inputs::Actions::MilestoneInputType], required: false
      argument :checklist, [Types::Inputs::Actions::ChecklistInputType], required: false

      # measurements
      argument :slack, Types::Inputs::Measurements::SlackInputType, required: false
    end
  end
end
