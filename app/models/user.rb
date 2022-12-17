# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string(255)      not null
#  email_verified     :boolean          default(FALSE)
#  invite_status      :integer          default("invited")
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
  has_many :workspace_members, dependent: :destroy
  has_many :workspaces, through: :workspace_members
  has_many :plans, dependent: :destroy
  has_many :goals, through: :plans
  has_many :integrations, dependent: :destroy

  enum invite_status: {
    invited: 0,
    joined: 1
  }

  def self.signup(email:, password:, name:)
    User.transaction do
      password_encrypted = BCrypt::Engine.hash_secret(password,
                                                      Rails.application.credentials.config[:password_salt])
      new_user = User.find_by(email:) || User.new(email:, password_encrypted:, name:)
      new_user.save!
      Workspace.create_default!(user: new_user)
      new_user
    end
  end
end
