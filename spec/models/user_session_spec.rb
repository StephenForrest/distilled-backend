# frozen_string_literal: true

# == Schema Information
#
# Table name: user_sessions
#
#  id         :bigint           not null, primary key
#  expired    :boolean          default(TRUE), not null
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
require 'rails_helper'

RSpec.describe UserSession, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
