# frozen_string_literal: true

# == Schema Information
#
# Table name: actions
#
#  id                  :bigint           not null, primary key
#  tracking_type       :integer          default("checklist"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  action_object_id    :integer          default(-1), not null
#  success_criteria_id :bigint           not null
#
# Indexes
#
#  index_actions_on_success_criteria_id  (success_criteria_id)
#
class Action < ApplicationRecord
  belongs_to :success_criteria
  has_many :checklists, dependent: :destroy

  enum tracking_type: {
    checklist: 0,
    milestone: 1
  }

  def tracking
    raise 'unknown tracking type' unless tracking_type.to_sym == :checklist

    checklists.first
  end

  def create_settings!(tracking_settings)
    raise "Unknown tracking type: #{tracking_type}" unless tracking_type.to_sym == :checklist

    checklists.create!(settings: tracking_settings.as_json)
  end
end
