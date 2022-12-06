# frozen_string_literal: true

class FixTypoOnSucceesCritereaTable < ActiveRecord::Migration[7.0]
  def up
    change_table :success_criterias, bulk: true do |t|
      t.remove :success_critera_type
      t.integer :success_criteria_type, default: 0, null: false
    end
  end

  def down
    t.remove :success_criteria_type
    t.integer :success_critera_type, default: 0, null: false
  end
end
