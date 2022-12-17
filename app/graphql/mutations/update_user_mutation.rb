# frozen_string_literal: true

module Mutations
  class UpdateUserMutation < BaseAuthorizedMutation
    argument :name, String, required: true

    field :user, type: Types::User::CurrentUserType, null: false

    def resolve(name:)
      current_user.update!(name:)
      { user: current_user.reload }
    end
  end
end
