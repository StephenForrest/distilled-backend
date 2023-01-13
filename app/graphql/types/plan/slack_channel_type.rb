# frozen_string_literal: true

module Types
  module Plan
    class SlackChannelType < Types::BaseObject
      field :id, type: ID, null: false
      field :name, type: String, null: true
      field :slack_channel_id, type: String, null: true
    end
  end
end
