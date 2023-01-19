# frozen_string_literal: true

module Types
  module Plan
    module Measurements
      class MeasurementSlackType < Types::BaseObject
        field :id, String, null: false
        field :integration_id, String, null: true
        field :metric, String, null: false
        field :value, Int, null: false
        field :channel_filters, type: [SlackChannelType], null: true

        def channel_filters
          object.slack_channels
        end
      end
    end
  end
end
