# == Schema Information
#
# Table name: focus_areas
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#
# Indexes
#
#  index_focus_areas_on_plan_id  (plan_id)
#
require 'rails_helper'

RSpec.describe FocusArea, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
