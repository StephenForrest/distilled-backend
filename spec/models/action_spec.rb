# frozen_string_literal: true

# == Schema Information
#
# Table name: actions
#
#  id                  :bigint           not null, primary key
#  action_type         :integer          default("checklist"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  action_object_id    :integer          default(-1), not null
#  success_criteria_id :bigint
#
# Indexes
#
#  index_actions_on_success_criteria_id  (success_criteria_id)
#
require 'rails_helper'

RSpec.describe Action, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
