# frozen_string_literal: true

class CreateWorkspaceMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :workspace_members do |t|
      t.references :workspace, null: false
      t.references :user, null: false
      t.integer :role, null: false, default: 0
      t.timestamps
    end
  end
end
