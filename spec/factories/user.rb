# frozen_string_literal: true

# This will guess the User class
FactoryBot.define do
  factory :user do
    name  { 'John Doe' }
    email { 'john@example.com' }
    password_encrypted { BCrypt::Engine.hash_secret('test', Rails.application.credentials.config[:password_salt]) }

    factory :user_with_workspace do
      after(:create) do |user|
        workspace = create(:workspace)
        create(:workspace_member, user:, workspace:)
      end
    end
  end
end
