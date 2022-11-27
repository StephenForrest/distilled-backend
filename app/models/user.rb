# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string(255)      not null
#  first_name         :string(255)      not null
#  last_name          :string(255)      not null
#  password_encrypted :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#
class User < ApplicationRecord
  def self.signup(email:, password:, firstname:, lastname:)
    User.transaction do
      password_encrypted = BCrypt::Engine.hash_secret(password,
                                                      Rails.application.credentials.config[:password_salt])
      new_user = User.new(email:, password_encrypted:, name:)
      new_user.save!

      new_user
    end
  end
end
