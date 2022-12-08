# frozen_string_literal: true

module Types
  module Plan
    module Actions
      class BaseActionType < Types::BaseObject
        def serialize_settings(settings)
          settings.map { |s| s.deep_transform_keys { |k| k.camelize(:lower) } }
        end
      end
    end
  end
end
