# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, limit: 255, null: false, index: true, unique: true
      t.string :name, limit: 255, null: false
      t.string :password_encrypted, limit: 255, null: false
      t.timestamps
    end
  end
end
