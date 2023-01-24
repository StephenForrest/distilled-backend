# frozen_string_literal: true

# == Schema Information
#
# Table name: workspaces
#
#  id                    :bigint           not null, primary key
#  auto_created          :boolean          default(TRUE), not null
#  auto_join_from_domain :boolean          default(FALSE), not null
#  boolean               :boolean          default(FALSE), not null
#  domain                :string
#  string                :string
#  stripe_product        :string
#  title                 :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Workspace < ApplicationRecord
  has_many :workspace_members, dependent: :destroy
  has_many :integrations, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :users, through: :workspace_members

  has_many :goals, dependent: :destroy

  has_many :success_criterias, dependent: :destroy

  has_many :actions, dependent: :destroy
  has_many :checklists, dependent: :destroy
  has_many :milestones, dependent: :destroy

  has_many :measurements, dependent: :destroy
  has_many :measurements_slacks, dependent: :destroy, class_name: 'Measurements::Slack'

  has_many :integrations, dependent: :destroy

  def self.create_default!(user:)
    workspace = Workspace.create!(
      title: [Forgery::Basic.color, Forgery::Address.street_name.split(' ').first, rand(1000)].join('-').downcase
    )
    workspace.workspace_members.create!(user:, role: 'admin')
    workspace
  end

  def public_domain?
    ['gmail', 'outlook', 'yahoo', 'hey.com'].any? { |d| domain&.include? d }
  end
end
