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
FactoryBot.define do
  factory :user_session do
    session_id { '12312312314123123' }
    user { user(:user) }
    expired { false }
  end
end
