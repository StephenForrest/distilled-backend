# frozen_string_literal: true

class CreateSuccessCriteras < ActiveRecord::Migration[7.0]
  def change
    create_table :success_criterias do |t|
      t.references :goal, null: false
      t.integer :success_criteria_type, default: 0, null: false
      t.integer :success_criteria_id, defauls: -1, null: false
      t.datetime :start_date, null: true
      t.datetime :end_date, null: true
      t.bigint :owner_id, null: false, default: -1
      t.timestamps
    end
  end
end
