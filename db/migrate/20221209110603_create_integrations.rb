# frozen_string_literal: true

class CreateIntegrations < ActiveRecord::Migration[7.0]
  def change
    create_table :integrations do |t|
      t.references :user, null: false
      t.references :workspace, null: false
      t.string :name, null: false, default: ''
      t.integer :integration_type, default: 0, null: false
      t.timestamps
    end
  end
end
