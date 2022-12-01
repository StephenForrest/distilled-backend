# frozen_string_literal: true

class CreateFocusAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :focus_areas do |t|
      t.references :plan, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
