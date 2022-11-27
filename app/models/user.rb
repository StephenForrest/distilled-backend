# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string(255)      not null
#  name               :string(255)      not null
#  password_encrypted :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#
class User < ApplicationRecord
  has_many :user_sessions, dependent: :destroy

  def self.signup(email:, password:, name:)
    User.transaction do
      password_encrypted = BCrypt::Engine.hash_secret(password,
                                                      Rails.application.credentials.config[:password_salt])
      new_user = User.new(email:, password_encrypted:, name:)
      new_user.save!

      new_user
    end
  end
end
