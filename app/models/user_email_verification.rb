# frozen_string_literal: true

# == Schema Information
#
# Table name: user_email_verifications
#
#  id         :bigint           not null, primary key
#  expired    :boolean          default(FALSE)
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_email_verifications_on_user_id  (user_id)
#
class UserEmailVerification < ApplicationRecord
  belongs_to :user
end
