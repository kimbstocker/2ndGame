class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
      @order = Order.find(params[:id])

    end
  
    def webhook 
        payment_intent_id = params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
        pp payment
        order_id = payment.metadata.order_id
        pp payment.charges.data[0].receipt_url
        @order = Order.find(order_id)
        @order.update(order_status: 2)
        items = @order.items
        items.each do |item|
            item.update(sold:true)
            listing = Listing.find_by(id: item.listing_id)
            listing.update(listing_status: 3)
        end

    end 
end
