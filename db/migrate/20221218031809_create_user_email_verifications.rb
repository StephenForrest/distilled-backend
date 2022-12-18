# frozen_string_literal: true

class CreateUserEmailVerifications < ActiveRecord::Migration[7.0]
  def change
    create_table :user_email_verifications do |t|
      t.references :user, null: false
      t.string :token, null: false
      t.boolean :expired, default: false
      t.timestamps
    end
  end
end
