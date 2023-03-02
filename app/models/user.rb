# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string(255)      not null
#  email_verified     :boolean          default(FALSE)
#  invite_status      :integer          default("invited")
#  first_name         :string(255)
#  last_name          :string(255)
#  position           :string(255)
#  company            :string(255)
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
  SIGNUP_ATTRIBUTES = %i[first_name last_name position company].freeze
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

  def self.signup(email:, password:, **options)
    transaction do
      password_encrypted = BCrypt::Engine.hash_secret(password, Rails.application.credentials.config[:password_salt])
      find_or_create_by(email:).tap do |user|
        user.update!(options.slice(*SIGNUP_ATTRIBUTES).merge(password_encrypted:))
        create_or_add_to_workspace
        create_verification_email
      end
    end
  end

  def self.signup_google(email:, **options)
    User.transaction do
      find_or_create_by(email:).tap do |user|
        user.update!(options.slice(*SIGNUP_ATTRIBUTES))
        create_or_add_to_workspace
        create_verification_email
      end
    end
  end

  def create_or_add_to_workspace
    return if workspaces.present?

    existing_workspace = Workspace.find_by(domain: user_domain, auto_join_from_domain: true)
    if existing_workspace.present?
      existing_workspace.workspace_members.create!(user: self)
    elsif public_domain?
      Workspace.create_default!(user: self)
    end
  end

  def create_verification_email
    token = SecureRandom.uuid
    user_email_verifications.create!(token:)
    UserMailer.with(user: self, token:).verify_email.deliver_later
  end

  def user_domain
    email.split('@').last
  end

  def public_domain?
    ['gmail', 'outlook', 'yahoo', 'hey.com'].any? { |d| user_domain&.include? d }
  end
end
