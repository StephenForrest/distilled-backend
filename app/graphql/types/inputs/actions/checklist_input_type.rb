# frozen_string_literal: true

module Types
  module Inputs
    module Actions
      class ChecklistInputType < Types::BaseInputObject
        argument :id, String, required: true
        argument :item, String, required: true
        argument :due_date, String, required: true
      end
    end
  end
end
