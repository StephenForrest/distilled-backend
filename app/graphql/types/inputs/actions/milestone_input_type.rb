# frozen_string_literal: true

module Types
  module Inputs
    module Actions
      class MilestoneInputType < Types::BaseInputObject
        argument :percent, Integer, required: true
        argument :item, String, required: true
        argument :due_date, String, required: true
        argument :checked, Boolean, required: true
      end
    end
  end
end
