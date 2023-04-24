# app/components/flask_purchase_component.rb

class FlaskPurchaseComponent < ViewComponent::Base
    def initialize(quantity: 1)
      @stripe_public_key = ENV['STRIPE_PUBLIC_KEY']
      @stripe_price_id = ENV['STRIPE_PRICE_ID']
      @success_url = 'http://localhost:3000/success'
      @cancel_url = 'http://localhost:3000/cancel'
      @quantity = quantity
    end
  
    def price_per_flask
      '$23.99'
    end
  
    def quantity_options
      (1..10).to_a
    end
  
    def total
      '$' + (@quantity * 23.99).to_s
    end
  end
  