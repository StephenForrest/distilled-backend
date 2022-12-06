# frozen_string_literal: true

class CreateChecklists < ActiveRecord::Migration[7.0]
  def change
    create_table :checklists do |t|
      t.references :action, null: false
      t.json :settings, default: {}
      t.timestamps
    end
  end
end
