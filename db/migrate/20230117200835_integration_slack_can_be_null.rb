class IntegrationSlackCanBeNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :measurements_slack, :integrations_slack_id, true
  end
end
