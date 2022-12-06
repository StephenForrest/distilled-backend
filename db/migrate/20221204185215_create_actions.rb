# frozen_string_literal: true

class CreateActions < ActiveRecord::Migration[7.0]
  def change
    create_table :actions do |t|
      t.references :success_criteria, null: false
      t.integer :action_type, default: 0, null: false
      t.integer :action_object_id, default: -1, null: false
      t.timestamps
    end
  end
end
