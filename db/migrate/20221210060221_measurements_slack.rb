# frozen_string_literal: true

class MeasurementsSlack < ActiveRecord::Migration[7.0]
  def change
    create_table :measurements_slack do |t|
      t.references :integrations_slack, null: false
      t.references :workspace, null: false
      t.references :measurement, null: false
      t.json :settings, null: false
      t.timestamps
    end
  end
end
