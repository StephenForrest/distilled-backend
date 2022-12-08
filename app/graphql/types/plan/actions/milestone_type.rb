# frozen_string_literal: true

module Types
  module Plan
    module Actions
      class MilestoneType < BaseActionType
        field :id, String, null: false
        field :settings, GraphQL::Types::JSON, null: false

        def settings
          { "milestone": serialize_settings(object.settings['milestone']) }
        end
      end
    end
  end
end
