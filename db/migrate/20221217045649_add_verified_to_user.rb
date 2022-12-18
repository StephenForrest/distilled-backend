# frozen_string_literal: true

class AddVerifiedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_verified, :boolean, default: false, null: true
  end
end
