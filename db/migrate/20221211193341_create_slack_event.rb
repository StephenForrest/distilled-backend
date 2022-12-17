# frozen_string_literal: true

class CreateSlackEvent < ActiveRecord::Migration[7.0]
  def change
    create_table :slack_events do |t|
      t.string :event_id, null: false, index: true, unique: true
      t.string :team_id, null: false, index: true
      t.json :event, null: false, default: {}
      t.timestamps
    end
  end
end
