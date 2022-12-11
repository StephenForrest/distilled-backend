# frozen_string_literal: true

class IntegrationsSlack < ActiveRecord::Migration[7.0]
  def change
    create_table :integrations_slack do |t|
      t.references :integration, null: false
      t.references :workspace, null: false
      t.text :token, null: false
      t.string :team_id, null: false
      t.string :team_name, null: false, default: ''
      t.json :scopes, null: false, default: []
      t.timestamps
    end
  end
end
