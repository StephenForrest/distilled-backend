class RenameActionTypeToTrackingType < ActiveRecord::Migration[7.0]
  def change
    rename_column :actions, :action_type, :tracking_type
  end
end
