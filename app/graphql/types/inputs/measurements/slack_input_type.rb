# frozen_string_literal: true

module Types
  module Inputs
    module Measurements
      class SlackInputType < Types::BaseInputObject
        argument :id, String, required: false
        argument :integration_id, String, required: true
        argument :channel_filters, [String], required: false
        argument :value, Integer, required: false
        argument :metric, String, required: false
      end
    end
  end
end
