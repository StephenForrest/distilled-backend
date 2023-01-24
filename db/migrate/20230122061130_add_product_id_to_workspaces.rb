class AddProductIdToWorkspaces < ActiveRecord::Migration[7.0]
  def change
    add_column :workspaces, :stripe_product, :string, null: true
  end
end
