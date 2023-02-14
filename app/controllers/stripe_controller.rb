# frozen_string_literal: true

class StripeController < ApplicationController
  include StripeHelper

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

    case event.type
    when 'checkout.session.completed'
      email = event.data.object.customer_details.email
      domain = email.match(/\@(.+)/)[1]
      workspace = Workspace.find_by(title: domain)
    
      if workspace
        StripeCustomer.find_or_create_by!(
          stripe_customer_id: event.data.object.customer, workspace: workspace
        )
        Rails.logger.info "Stripe checkout session completed - Workspace with id: #{workspace.id} was found and associated with stripe customer id: #{event.data.object.customer}"
      else
        Rails.logger.error "Stripe checkout session completed - Workspace with email domain: #{domain} was NOT found"
      end    
    when 'customer.subscription.created'
      update_workspace_quantity(event)
      workspace = StripeCustomer.find_by(stripe_customer_id: event.data.object.customer).workspace
      if workspace
        workspace.update!(stripe_product: event.data.object.plan.product)
        Workspaces::OnboardingSteps.new(workspace).pass_onboarding_step('subscription')
        Rails.logger.info "Stripe customer subscription created - Workspace with id: #{workspace.id} was found and updated with product: #{event.data.object.plan.product}"
      else
        Rails.logger.error "Stripe customer subscription created - Stripe customer with id: #{event.data.object.customer} was NOT found"
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
