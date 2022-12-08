# frozen_string_literal: true

module Types
  module Plan
    module Actions
      class ChecklistType < BaseActionType
        field :id, String, null: false
        field :settings, GraphQL::Types::JSON, null: false

        def settings
          { "checklist": serialize_settings(object.settings['checklist']) }
        end
      end
    end
  end
end
