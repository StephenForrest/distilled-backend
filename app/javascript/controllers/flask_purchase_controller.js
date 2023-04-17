// app/javascript/controllers/flask_purchase_controller.js

import { Controller } from "stimulus"
import { loadStripe } from '@stripe/stripe-js/pure'

export default class extends Controller {
  static targets = ['quantity', 'total', 'checkoutButton']

  initialize() {
    this.stripePromise = loadStripe(process.env.STRIPE_PUBLIC_KEY)
  }

  async checkout() {
    const stripe = await this.stripePromise

    stripe.redirectToCheckout({
      lineItems: [{
        price: process.env.STRIPE_PRICE_ID,
        quantity: this.quantityTarget.value
      }],
      mode: 'payment',
      successUrl: process.env.STRIPE_SUCCESS_URL,
      cancelUrl: process.env.STRIPE_CANCEL_URL
    })
  }

  updateTotal() {
    const quantity = parseInt(this.quantityTarget.value)
    this.totalTarget.textContent = `$${(quantity * 23.99).toFixed(2)}`
  }
}
