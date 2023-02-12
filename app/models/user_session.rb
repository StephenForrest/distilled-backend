# frozen_string_literal: true

# == Schema Information
#
# Table name: user_sessions
#
#  id         :bigint           not null, primary key
#  expired    :boolean          default(TRUE), not null
#  login_type :integer          default("email"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  session_id :string           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_session              (user_id,session_id) UNIQUE
#  index_user_sessions_on_user_id  (user_id)
#
class UserSession < ApplicationRecord
  belongs_to :user

  scope :active, -> { where(expired: false) }

  enum login_type: {
    email: 0,
    google: 1
  }

  def expire!
    update!(expired: true)
  end

  def self.login(email:, password:)
    user = User.find_by(email:)
    password_hash = BCrypt::Engine.hash_secret(password, Rails.application.credentials.config[:password_salt])
    raise ::Errors::InvalidCredentials if user.nil? || user.password_encrypted != password_hash

    UserSession.generate_user_session(user:, login_type: 'email')
  end

  def generate_token(user_id)
    payload = { user_id: user_id, exp: Time.now.to_i + 3600 }
    JWT.encode(payload, secret, 'RS256')
  end


  def validate_token(token)
    decoded_token = JWT.decode(token, secret, true, { algorithm: 'RS256' })
    decoded_token.first["user_id"]
  end

  def self.generate_user_session(user:, login_type:)
    session_id = SecureRandom.hex(64)
    create!(session_id:, user:, expired: false, login_type:)
  end
end
