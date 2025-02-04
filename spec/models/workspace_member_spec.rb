# frozen_string_literal: true

# == Schema Information
#
# Table name: workspace_members
#
#  id           :bigint           not null, primary key
#  api_key      :uuid             not null
#  role         :integer          default("admin"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  workspace_id :bigint           not null
#
# Indexes
#
#  index_workspace_members_on_user_id       (user_id)
#  index_workspace_members_on_workspace_id  (workspace_id)
#
require 'rails_helper'

RSpec.describe WorkspaceMember, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
