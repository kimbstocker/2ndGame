class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
      @order = Order.find(params[:id])

    end
  
    def webhook

        #Ensure only Stripe webhook 
        begin
            payload = request.raw_post
            header = request.headers["HTTP_STRIPE_SIGNATURE"]
            secret = Rails.application.credentials.dig(:stripe, :webhook_signing_secret)
            event = Stripe::Webhook.construct_event(payload, header, secret)
        rescue Stripe::SignatureVerificationError => e
            render json: {error: "Unauthorised"}, status: 403
            return
        rescue JSON::PasserError => e
            render json: {error: "Bad request"}, status: 422
            return            
        end
        
        payment_intent_id = event.data.object.payment_intent
        # payment_intent_id = params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
        pp payment
        order_id = payment.metadata.order_id
        pp payment.charges.data[0].receipt_url
        #update order, listing and item statuses.
        order = Order.find(order_id)
        order.update(order_status: 2)
        items = order.items
        items.each do |item|
            item.update(sold:true)
            listing = Listing.find_by(id: item.listing_id)
            listing.update(listing_status: 3)
        end

    end 
end
