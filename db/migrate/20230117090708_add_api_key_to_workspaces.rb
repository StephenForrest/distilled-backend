class AddApiKeyToWorkspaces < ActiveRecord::Migration[7.0]
  def change
    add_column :workspace_members, :api_key, :uuid, null: false, index: { unique: true }, default: 'gen_random_uuid()'
  end
end
