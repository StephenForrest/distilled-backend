# frozen_string_literal: true

module Mutations
  class SignUpMutation < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :name, String, required: true

    field :session_id, String, null: false

    def resolve(email:, password:, name:)
      user = User.find_by(email:)
      raise GraphQL::ExecutionError, 'User already exists' if user.present?

      new_user = User.signup(email:, password:, name:)
      UserSession.login(email: new_user.email, password:)
    end
  end
end
