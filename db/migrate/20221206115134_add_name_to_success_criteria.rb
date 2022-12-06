class AddNameToSuccessCriteria < ActiveRecord::Migration[7.0]
  def change
    add_column :success_criterias, :name, :string, null: false, required: true, default: ''
  end
end
