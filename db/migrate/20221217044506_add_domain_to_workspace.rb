class AddDomainToWorkspace < ActiveRecord::Migration[7.0]
  def change
    change_table :workspaces, bulk: true do |t|
      t.string :domain, :string, null: true
      t.boolean :auto_join_from_domain, :boolean, null: false, default: false
    end
  end
end
