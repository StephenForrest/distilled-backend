# frozen_string_literal: true

module Types
  module Inputs
    module Measurements
      class SlackChannelFilterInputType < Types::BaseInputObject
        argument :slack_channel_id, String, required: true
        argument :name, String, required: true
      end

      class SlackInputType < Types::BaseInputObject
        argument :id, String, required: false
        argument :integration_id, String, required: false
        argument :channel_filters, [SlackChannelFilterInputType], required: true
        argument :value, Integer, required: false
        argument :metric, String, required: false
      end
    end
  end
end
