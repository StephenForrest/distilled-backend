# frozen_string_literal: true

class AddEmailAndInviteStatusToWorkspaceMember < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.integer :invite_status, default: 0
    end
  end
end
