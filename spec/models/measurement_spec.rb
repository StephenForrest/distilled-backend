# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
#
#  id                  :bigint           not null, primary key
#  tracking_status     :integer          default(0), not null
#  tracking_type       :integer          default("slack"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  success_criteria_id :bigint           not null
#  workspace_id        :bigint           not null
#
# Indexes
#
#  index_measurements_on_success_criteria_id  (success_criteria_id)
#  index_measurements_on_workspace_id         (workspace_id)
#
require 'rails_helper'

RSpec.describe Measurement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
