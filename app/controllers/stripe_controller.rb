# frozen_string_literal: true

class StripeController < ApplicationController
  def webhooks
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        request.body.read, request.headers['HTTP_STRIPE_SIGNATURE'], ENV.fetch('STRIPE_WEBHOOK_ENDPOINT_SECRET')
      )
    rescue JSON::ParserError => e
      # Invalid payload
      Rails.logger.error("Stripe #1 #{e.inspect}")
      render json: 'Something is wrong', status: :unauthorized
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render json: 'Something is wrong', status: :unauthorized
      Rails.logger.error("Stripe #2 #{e.inspect}")
      return
    end

    Rails.logger.info("Stripe webhook received: #{event.type}")

    case event.type
    when 'checkout.session.completed'
      Rails.logger.info("Stripe webhook checkout.session.completed: #{event.data.object.inspect}")
      StripeCustomer.find_or_create_by!(
        stripe_customer_id: event.data.object.customer, workspace_id: event.data.object.client_reference_id
      )
    when 'customer.subscription.created'
      Rails.logger.info("Stripe webhook customer.subscription.created: #{event.data.object.inspect}")
      stripe_customer = StripeCustomer.find_by(stripe_customer_id: event.data.object.customer)
      if stripe_customer.present?
        workspace = stripe_customer.workspace
        workspace.update!(stripe_product: event.data.object.plan.product)
        Workspaces::OnboardingSteps.new(workspace).pass_onboarding_step('subscription')
      else
        Rails.logger.error("Stripe webhook customer.subscription.created: StripeCustomer not found for stripe_customer_id #{event.data.object.customer}")
      end    
    when 'charge.failed'
      Rails.logger.error("Stripe charge.failed for #{event.data.object.inspect}")
    when 'invoice.payment_failed'
      Rails.logger.error("Stripe invoice.payment_failed for #{event.data.object.inspect}")
    when 'payout.failed'
      Rails.logger.error("Stripe payout.failed for #{event.data.object.inspect}")
    else
      :noop
    end

    render json: :ok
  end
end
