# frozen_string_literal: true

# == Schema Information
#
# Table name: checklists
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
#  index_checklists_on_action_id     (action_id)
#  index_checklists_on_workspace_id  (workspace_id)
#
class Checklist < ApplicationRecord
  belongs_to :action
  belongs_to :workspace

  def completion
    items = settings['checklist']
    completed_items = items.select { |s| s['checked'] }
    completed_items.size.to_f / items.size
  end

  # rubocop:disable Metrics/AbcSize
  def self.validate_settings(action, tracking_settings)
    errors = ValidationErrors.new
    tracking_settings.each do |setting|
      setting_error = ValidationErrors.new
      setting_error.add('item', 'Give it a name') if setting[:item].blank?
      if DateTime.parse(setting[:due_date]).utc > action.success_criteria.end_date.utc
        setting_error.add('due_date', "Due date cannot be later than the action's due date")
      end
      errors.add(setting[:id], setting_error) if setting_error.present?
    end
    errors
  end
  # rubocop:enable Metrics/AbcSize
end
