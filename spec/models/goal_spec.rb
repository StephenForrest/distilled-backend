# frozen_string_literal: true

# == Schema Information
#
# Table name: goals
#
#  id              :bigint           not null, primary key
#  expires_on      :datetime
#  progress        :integer          default(0), not null
#  title           :string           default(""), not null
#  tracking_status :integer          default("ontrack"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  owner_id        :bigint           default(-1), not null
#  plan_id         :bigint           not null
#
# Indexes
#
#  index_goals_on_plan_id  (plan_id)
#
require 'rails_helper'

RSpec.describe Goal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
