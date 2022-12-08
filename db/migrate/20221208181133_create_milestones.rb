# frozen_string_literal: true

class CreateMilestones < ActiveRecord::Migration[7.0]
  def change
    create_table :milestones do |t|
      t.references :workspace, null: false
      t.references :action, null: false
      t.json :settings, default: {}
      t.timestamps
    end
  end
end
