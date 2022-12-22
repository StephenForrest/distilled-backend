# frozen_string_literal: true

class AddProfilePicToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile_pic, :string, default: false, null: true
  end
end
