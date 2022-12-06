# frozen_string_literal: true

class FixTypo < ActiveRecord::Migration[7.0]
  def up
    change_table :actions, bulk: true do |t|
      t.remove :success_critera_id
      t.references :success_criteria
    end
  end

  def down
    t.remove :success_critera_id
    t.int :success_critera_id, null: true, default: 0
  end
end
