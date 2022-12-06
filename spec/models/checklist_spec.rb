# frozen_string_literal: true

# == Schema Information
#
# Table name: checklists
#
#  id         :bigint           not null, primary key
#  settings   :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  action_id  :bigint           not null
#
# Indexes
#
#  index_checklists_on_action_id  (action_id)
#
require 'rails_helper'

RSpec.describe Checklist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
