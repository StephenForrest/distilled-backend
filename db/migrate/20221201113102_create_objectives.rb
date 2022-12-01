# frozen_string_literal: true

class CreateObjectives < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.references :plan, null: false
      t.string :title, default: '', null: false
      t.timestamps
    end
  end
end
