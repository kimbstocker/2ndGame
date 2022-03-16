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
        receipt_url = payment.charges.data[0].receipt_url
        #update order, listing and item statuses.
        order = Order.find(order_id)
        order.update(order_status: 2)
        items = order.items
        order_total = 0
        items.each do |item|
            item.update(sold:true)
            listing = Listing.find_by(id: item.listing_id)
            listing.update(listing_status: 3)
            #Delete all other line items that have the same listing_id. Those items would have been created by other users around same time the item/listing was purchased
            Item.where(listing_id: listing.id, sold: false).destroy_all
            order_total += item.price
        end
        order.update(total: order_total)
        Payment.create(order_id: order.id, payment_id: payment_intent_id, receipt_url: receipt_url)
    end 
end
