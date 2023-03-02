# frozen_string_literal: true

module Mutations
  class UpdateUserMutation < BaseAuthorizedMutation
    argument :first_name, String, required: true
    argument :last_name, String, required: true

    field :user, type: Types::User::CurrentUserType, null: false

    def resolve(first_name:, last_name:)
      current_user.update!(first_name:)
      current_user.update!(last_name:)
      { user: current_user.reload }
    end
  end
end
