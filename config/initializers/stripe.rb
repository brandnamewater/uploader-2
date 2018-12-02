Rails.configuration.stripe = {
  :publishable_key => 'pk_test_WUSowiZS0TqTSqQJucPWU8kh',
  :secret_key      => 'sk_test_0IFhXRY60k0w89a7hCAaNs4I'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.signing_secret = 'whsec_UoHxVoiPkem44yC2qQYxU3cpcjXwOWzV'




StripeEvent.configure do |events|
  events.all do |event|
    # target specific events here
    #   if event.type == 'customer.source.created'
    #      source = event.data.object
    #      order = Order.where('stripe_customer_token LIKE ?', "%#{source['customer']}%").first
    #   if order
    #      customer = Stripe::Customer.retrieve(JSON.parse(order.stripe_customer_token)['id'])
    #      order.stripe_customer_token = customer.to_json
    #      order.save
    #   end
    # end
    #
    #   if event.type == 'charge.failed'
    #      source = event.data.object
    #      order = Order.where('stripe_customer_token LIKE ?', "%#{source['customer']}%").first
    #   if order
    #      customer = Stripe::Customer.retrieve(JSON.parse(order.stripe_customer_token)['id'])
    #      order.stripe_customer_token = customer.to_json
    #      order.video = nil
    #      order.save
    #   end
    # end

  end
end
