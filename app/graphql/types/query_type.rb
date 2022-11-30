# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :current_user, type: Types::User::CurrentUserType, null: false

    def current_user
      user = context[:current_user]
      raise GraphQL::ExecutionError, 'Authentication expired' if user.nil?

      user
    end
  end
end
