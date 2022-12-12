class AddMetricValueToMeasurement < ActiveRecord::Migration[7.0]
  def change
    add_column :measurements_slack, :metric_value, :integer, null: false, default: 0
  end
end
