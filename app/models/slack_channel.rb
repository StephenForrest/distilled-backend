# frozen_string_literal: true

# == Schema Information
#
# Table name: slack_channels
#
#  id               :uuid             not null, primary key
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slack_channel_id :string
#  slack_team_id    :string
#
# Indexes
#
#  index_slack_channels_on_slack_team_id_and_slack_channel_id  (slack_team_id,slack_channel_id) UNIQUE
#
class SlackChannel < ApplicationRecord
  has_and_belongs_to_many :measurement_slacks, association_foreign_key: 'measurements_slack_id',
                                               class_name: 'Measurements::Slack'
end
