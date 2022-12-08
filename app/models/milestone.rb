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
class Milestone < ApplicationRecord
  belongs_to :action
  belongs_to :workspace

  def completion
    items = settings['milestone']
    completed_items = items.select { |s| s['checked'] }
    completed_items.size.to_f / items.size
  end

  def self.validate_settings(_action, tracking_settings)
    errors = ValidationErrors.new
    tracking_settings.each do |setting, _index|
      setting_error = ValidationErrors.new
      setting_error.add('percent', '') if setting[:percent].blank?
      setting_error.add('item', 'give a description of the milestone') if setting[:item].blank?

      errors.add(setting[:percent].to_s, setting_error) if setting_error.present?
    end
    errors
  end
end
