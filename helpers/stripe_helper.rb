module StripeHelper
    def update_workspace_quantity(event)
      workspace = StripeCustomer.find_by(stripe_customer_id: event.data.object.customer).workspace
  
      if workspace
        workspace.update!(stripe_product: event.data.object.id)
      else
        Rails.logger.error "Stripe customer subscription created - Stripe customer with id: #{event.data.object.customer} was NOT found"
      end
    end
  end