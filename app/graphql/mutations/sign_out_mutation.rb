# frozen_string_literal: true

module Mutations
  class SignOutMutation < BaseMutation
    argument :session_id, String, required: true

    field :session_id, String, null: true

    def resolve(session_id:)
      user_session = UserSession.active.find_by(session_id:)
      user_session.expire! if user_session.present?

      user_session
    end
  end
end
