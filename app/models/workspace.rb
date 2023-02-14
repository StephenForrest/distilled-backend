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
#  onboarding_steps      :jsonb            not null
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

def user_restrictions
  customer = Stripe::Customer.retrieve(workspace.stripe_customer_id)
  subscription = customer.subscriptions.data.first

  current_quantity = subscription.quantity

  case current_quantity
  when 1..2
    max_users = 2
  when 3..4
    max_users = 4
  when 5..6
    max_users = 6
  when 7..8
    max_users = 8
  when 9..10
    max_users = 10
  when 11..12
    max_users = 12
  when 13..14
    max_users = 14
  when 15..16
    max_users = 16
  when 17..18
    max_users = 18
  when 19..20
    max_users = 20
  when 21..22
    max_users = 22
  when 23..24
    max_users = 24
  else
    max_users = 25
  end

  if workspace.users = workspace.users.limit(max_users)
    raise GraphQL::ExecutionError, "You have reached the maximum number of users for your plan. Please upgrade your plan to add more users."
  end

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
