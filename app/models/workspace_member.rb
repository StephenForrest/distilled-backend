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

  after_create :update_stripe_subscription_quantity

  private

  def update_stripe_subscription_quantity
    # Find the workspace and its associated Stripe subscription
    workspace = self.workspace
    subscription = Stripe::Subscription.retrieve(workspace.stripe_product)

    # Update the subscription's quantity to reflect the number of members
    quantity = workspace.workspace_members.count
    Stripe::Subscription.update(
      subscription.id,
      quantity: quantity
    )

    Rails.logger.info "Stripe subscription with id: #{subscription.id} was updated with a quantity of #{quantity}"

  enum :role, {
    admin: 0
  }
end
