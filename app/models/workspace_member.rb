# frozen_string_literal: true

# == Schema Information
#
# Table name: workspace_members
#
#  id           :bigint           not null, primary key
#  api_key      :uuid             not null
#  role         :integer          default("admin"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  workspace_id :bigint           not null
#
# Indexes
#
#  index_workspace_members_on_user_id       (user_id)
#  index_workspace_members_on_workspace_id  (workspace_id)
#
class WorkspaceMember < ApplicationRecord
  belongs_to :workspace
  belongs_to :user

  private

  def update_subscription_quantity
    workspace = self.workspace
    customer = Stripe::Customer.retrieve(workspace.stripe_customer_id)
    subscription = customer.subscriptions.data.first
    quantity = workspace.workspace_members.count
    Stripe::Subscription.update(subscription.id, quantity: quantity)
  end

  enum :role, {
    admin: 0
  }
end
