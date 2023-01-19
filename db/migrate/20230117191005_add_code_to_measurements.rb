class AddCodeToMeasurements < ActiveRecord::Migration[7.0]
  def change
    add_column :measurements, :code, :string, null: true, index: { unique: true }
  end
end
