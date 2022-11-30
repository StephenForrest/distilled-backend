# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.references :workspace, null: false
      t.references :user, null: false
      t.string :name, default: '', null: false
      t.timestamps
    end
  end
end
