# frozen_string_literal: true

class AddTrackedToSlackEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :slack_events, :tracked, :boolean, default: false, null: false, index: true
  end
end
