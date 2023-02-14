module StripeHelper
  def add_user_to_workspace_subscription(stripe_customer_id, current_workspace)
    stripe_subscription = current_workspace.stripe_product
    quantity = current_workspace.users.count + 1
    stripe_subscription.quantity = quantity
    stripe_subscription.save
  end
end