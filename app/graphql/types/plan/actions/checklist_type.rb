# frozen_string_literal: true

module Types
  module Plan
    module Actions
      class ChecklistType < Types::BaseObject
        field :id, String, null: false
        field :settings, GraphQL::Types::JSON, null: false

        def settings
          { "checklist": object.settings['checklist'].map { |s| s.deep_transform_keys { |k| k.camelize(:lower) } } }
        end
      end
    end
  end
end
