# frozen_string_literal: true

class AddColumnsToSlackMeasurement < ActiveRecord::Migration[7.0]
  def change
    # rubocop:disable Rails/BulkChangeTable
    # rubocop:disable Rails/ReversibleMigration
    add_column :measurements_slack, :value, :integer, null: false, default: 0
    add_column :measurements_slack, :metric, :integer, null: false, default: 0
    remove_column :measurements_slack, :settings
    # rubocop:enable Rails/BulkChangeTable Rails/ReversibleMigration
    # rubocop:enable Rails/ReversibleMigration
  end
end
