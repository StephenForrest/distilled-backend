# frozen_string_literal: true

class FixSuccessCritereaSchema < ActiveRecord::Migration[7.0]
  def up
    change_table :success_criterias, bulk: true do |t|
      t.remove :success_criteria_id
      t.text :description, default: '', null: true
    end
  end

  def down
    change_table :success_criterias, bulk: true do |t|
      t.integer :success_criteria_id, null: false, default: -1
      t.remove :description
    end
  end
end
