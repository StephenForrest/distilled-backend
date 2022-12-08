# frozen_string_literal: true

# == Schema Information
#
# Table name: milestones
#
#  id           :bigint           not null, primary key
#  settings     :json
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  action_id    :bigint           not null
#  workspace_id :bigint           not null
#
# Indexes
#
#  index_milestones_on_action_id     (action_id)
#  index_milestones_on_workspace_id  (workspace_id)
#
require 'rails_helper'

RSpec.describe Milestone, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
