# frozen_string_literal: true

class CreateMeasurements < ActiveRecord::Migration[7.0]
  def change
    create_table :measurements do |t|
      t.references :success_criteria, null: false
      t.integer :measurement_type, default: 0, null: false
      t.integer :tracking_status, default: 0, null: false
      t.timestamps
    end
  end
end
