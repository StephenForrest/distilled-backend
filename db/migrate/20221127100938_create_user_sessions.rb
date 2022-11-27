# frozen_string_literal: true

class CreateUserSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sessions do |t|
      t.references :user, null: false
      t.string :session_id, null: false
      t.boolean :expired, null: false, default: true
      t.index %i[user_id session_id], name: 'index_user_session', unique: true
      t.timestamps
    end
  end
end
