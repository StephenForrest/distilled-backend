class AddUidToPlan < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :uuid, :string, null: false, required: true, default: ''
  end
end
