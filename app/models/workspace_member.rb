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

  def user_restrictions

    
    customer = Stripe::Customer.retrieve(workspace.stripe_customer_id)
    subscription = customer.subscriptions.data.first
  
    current_quantity = subscription.quantity
  
    if workspace.users = workspace.users.limit(max_users)
      raise GraphQL::ExecutionError, "You have reached the maximum number of users for your plan. Please upgrade your plan to add more users."
    end
  end
  

  enum :role, {
    admin: 0
  }
end
