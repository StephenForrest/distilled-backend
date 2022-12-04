# frozen_string_literal: true

class CreateObjectives < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.references :plan, null: false
      t.string :title, default: '', null: false
      t.datetime :expires_on, null: true
      t.integer :tracking_status, default: 0, null: false
      t.integer :progress, default: 0, null: false
      t.bigint :owner_id, null: false, default: -1
      t.timestamps
    end
  end
end
