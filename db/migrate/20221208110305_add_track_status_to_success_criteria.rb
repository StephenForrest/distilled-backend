class AddTrackStatusToSuccessCriteria < ActiveRecord::Migration[7.0]
  def change
    add_column :success_criterias, :tracking_status, :integer, null: false, default: 0
  end
end
