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
#  password_encrypted :string(255)
#  profile_pic        :string           default("f")
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
  has_many :user_email_verifications, dependent: :destroy

  enum invite_status: {
    invited: 0,
    joined: 1
  }

  def self.signup(email:, password:, name:)
    User.transaction do
      password_encrypted = BCrypt::Engine.hash_secret(password,
                                                      Rails.application.credentials.config[:password_salt])
      new_user = User.find_by(email:) || User.new(email:)
      new_user.update!(password_encrypted:, name:)
      new_user.create_or_add_to_workspace
      new_user.create_verification_email
      new_user
    end
  end

  def self.signup_google(email:, name:)
    User.transaction do
      new_user = User.find_by(email:) || User.new(email:)
      new_user.update!(name:)
      new_user.create_or_add_to_workspace
      new_user.create_verification_email
      new_user
    end
  end

  def create_or_add_to_workspace
    return if workspaces.present?

    existing_workspace = Workspace.find_by(domain: user_domain, auto_join_from_domain: true)
    if existing_workspace.present?
      existing_workspace.workspace_members.create!(user:)
    elsif public_domain?
      Workspace.create_default!(user: self)
    end
  end

  def create_verification_email
    token = SecureRandom.uuid
    user_email_verifications.create!(token:)
    UserMailer.with(user: self, token:).verify_email.deliver_later
  end

  def first_name
    name.split(' ').first || email
  end

  def user_domain
    email.split('@').last
  end

  def public_domain?
    ['gmail', 'outlook', 'yahoo', 'hey.com'].any? { |d| user_domain&.include? d }
  end
end
