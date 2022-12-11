# frozen_string_literal: true

class RenameMeasurementColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :measurements, :measurement_type, :tracking_type
  end
end
