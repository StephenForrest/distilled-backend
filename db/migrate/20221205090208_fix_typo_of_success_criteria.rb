class FixTypoOfSuccessCriteria < ActiveRecord::Migration[7.0]
  def change
    rename_column :success_criterias, :success_criteria_type, :success_criteria_type
    rename_column :measurements, :success_criteria_id, :success_criteria_id
    rename_column :actions, :success_criteria_id, :success_criteria_id
  end
end
