class CreateMeasurementSlackActionLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :measurement_slack_action_logs do |t|
      t.references :measurements_slacks, null: false
      t.integer :metric, default: 0, null: false
      t.integer :value, default: 0, null: false
      t.timestamps
    end
  end
end
