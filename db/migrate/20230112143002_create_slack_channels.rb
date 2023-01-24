class CreateSlackChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :slack_channels, id: :uuid do |t|
      t.string :name
      t.string :slack_channel_id
      t.string :slack_team_id
      t.timestamps
    end

    create_table :measurements_slack_slack_channels, id: :uuid do |t|
      t.references :measurements_slack, null: false, foreign_key: { to_table: :measurements_slack }, type: :bigint,
                                        index: { name: :index_mea_sl_sl_channels_on_measurements_slack_id }
      t.references :slack_channel, null: false, foreign_key: true, type: :uuid, index: true
      t.timestamps
    end

    add_index :slack_channels, %i[slack_team_id slack_channel_id], unique: true
  end
end
