# frozen_string_literal: true

# This will guess the User class
FactoryBot.define do
  factory :user_session do
    session_id { '12312312314123123' }
    user { user(:user) }
    expired { false }
  end
end
