# frozen_string_literal: true

class MakeUserPasswordOptional < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :password_encrypted, true
  end
end
