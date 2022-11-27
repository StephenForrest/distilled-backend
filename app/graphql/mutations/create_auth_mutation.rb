# frozen_string_literal: true

module Mutations
  class CreateAuthMutation < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :session_id, String, null: false

    def resolve(email:, password:)
      UserSession.login(email:, password:)
    rescue Errors::InvalidCredentials
      raise GraphQL::ExecutionError, 'Invalid credentials'
    end
  end
end
