# frozen_string_literal: true

class AddLoginTypeToUserSession < ActiveRecord::Migration[7.0]
  def change
    add_column :user_sessions, :login_type, :integer, default: 0, null: false
  end
end
