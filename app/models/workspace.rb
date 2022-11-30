# frozen_string_literal: true

# == Schema Information
#
# Table name: workspaces
#
#  id           :bigint           not null, primary key
#  auto_created :boolean          default(TRUE), not null
#  title        :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Workspace < ApplicationRecord
  has_many :workspace_members, dependent: :destroy
  has_many :integrations, dependent: :destroy
  has_many :plans, dependent: :destroy

  def self.create_default!(user:)
    workspace = Workspace.create!(
      title: [Forgery::Basic.color, Forgery::Address.street_name.split(' ').first, rand(1000)].join('-').downcase
    )
    workspace.workspace_members.create!(user:, role: 'admin')
    workspace
  end
end
