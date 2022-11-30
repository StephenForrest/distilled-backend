# frozen_string_literal: true

class CreateWorkspaces < ActiveRecord::Migration[7.0]
  def change
    create_table :workspaces do |t|
      t.string :title, limit: 255, null: false
      t.boolean :auto_created, default: true, null: false
      t.timestamps
    end
  end
end
