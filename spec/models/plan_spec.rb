# frozen_string_literal: true

# == Schema Information
#
# Table name: plans
#
#  id           :bigint           not null, primary key
#  name         :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  workspace_id :bigint           not null
#
# Indexes
#
#  index_plans_on_user_id       (user_id)
#  index_plans_on_workspace_id  (workspace_id)
#
require 'rails_helper'

RSpec.describe Plan, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
