# frozen_string_literal: true

# == Schema Information
#
# Table name: success_criterias
#
#  id                    :bigint           not null, primary key
#  description           :text             default("")
#  end_date              :datetime
#  name                  :string           default(""), not null
#  start_date            :datetime
#  success_criteria_type :integer          default("action"), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  goal_id               :bigint           not null
#  owner_id              :bigint           default(-1), not null
#
# Indexes
#
#  index_success_criterias_on_goal_id  (goal_id)
#
require 'rails_helper'

RSpec.describe SuccessCriteria, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
