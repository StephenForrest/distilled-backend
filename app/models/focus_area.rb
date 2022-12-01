# frozen_string_literal: true

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
class FocusArea < ApplicationRecord
end
