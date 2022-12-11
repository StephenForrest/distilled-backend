# frozen_string_literal: true

# == Schema Information
#
# Table name: integrations
#
#  id               :bigint           not null, primary key
#  integration_type :integer          default("slack"), not null
#  name             :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#  workspace_id     :bigint           not null
#
# Indexes
#
#  index_integrations_on_user_id       (user_id)
#  index_integrations_on_workspace_id  (workspace_id)
#
class Integration < ApplicationRecord
  belongs_to :workspace
  belongs_to :user
  has_many :integrations_slacks, dependent: :destroy, class_name: 'Integrations::Slack'

  enum integration_type: {
    slack: 0
  }

  def settings_class
    case integration_type.to_s
    when 'slack'
      Integrations::Slack
    else
      raise 'Invalid Integration'
    end
  end

  def settings
    case integration_type.to_s
    when 'slack'
      integrations_slacks.first
    else
      raise 'Invalid Integration'
    end
  end
end
