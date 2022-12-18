# frozen_string_literal: true

module Mutations
  class VerifyEmailMutation < BaseMutation
    argument :token, String, required: true, validates: { allow_blank: false }

    field :success, Boolean, null: true

    def resolve(token:)
      user_verification = UserEmailVerification.find_by(token:, expired: false)
      if user_verification.blank?
        raise GraphQL::ExecutionError,
              'This link has either expired or not valid to verify your email'
      end

      user_verification.user.update!(email_verified: true)
      success = user_verification.update!(expired: true)
      { success:}
    end
  end
end
