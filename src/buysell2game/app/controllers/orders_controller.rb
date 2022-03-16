class OrdersController < ApplicationController
    before_action :authorize_user
    before_action :set_order, only: [:edit, :update, :destroy]


    def index
      if !current_user.orders.find_by(order_status: "pending")
        flash[:notice] = "Your cart is empty!"
        redirect_to root_path
      else
        redirect_to order_path(current_user.orders.find_by(order_status: "pending").id)
      end

    end

    def show

      #Select order that has a "pending" status, should be only one as the create method has a check to make sure of it.
      
      @order = current_user.orders.find_by(order_status: "pending")
      #Below is to ensure when all items are removed from Order, there wont be a Stripe error as the total below will be $0
      @items = @order.items.all

      total_price = 0
      @items.each do |item|
        #Below code ensures only unsold items are added to the total payment before sending to stripe

        if item.sold == true
          flash[:notice] = "One or more item is no longer available. Review your order"
          redirect_to order_path
        else 
          total_price += item.listing.price
        end
      end
      
      total_cents = (total_price*100).to_i

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email:current_user && current_user.email, 
        line_items: [
            {
              name: "Pay 2ndGame Corp",
              amount: total_cents, 
              currency: 'aud',
              quantity: 1
            }
          ],
        #send metadata to Stripe and stripe send it back once payment is sucessful
        payment_intent_data: {
          metadata: {
            user_id: current_user && current_user.id, 
            order_id: @order.id
          }
        },
        success_url: "#{root_url}payments/success/#{@order.id}",
        cancel_url: root_url
      )
  
      @session_id = session.id
      
      
    end

    def new
        @order = Order.new
         
    end

    def create

      listing = Listing.find_by(id: params[:listing_id])

    # Only create a new line in Orders table if there isnt already one pending.
      if !current_user.orders.find_by(order_status: "pending")
        @order = Order.create(user_id: current_user.id)
        @order.items.create(listing_id: listing.id, price: listing.price)

      else
        @order = current_user.orders.find_by(order_status: "pending")
        if !@order.items.find_by(listing_id: listing.id)
          @order.items.create(listing_id: listing.id, price: listing.price)
          #TODO probaly need redirect. Find a way to display message without redirecting
          # flash.now[:notice] = "Item succesfully added"
        # else
          #TODO
          # flash.now[:notice] = "Item already added"
  
        end

      end



    end

    def edit
    end

    def update
    end

    def destroy
    end

private

    def set_order
        @order = Order.find(params[:id])

    end
    

    def authorize_user 
      if !user_signed_in?
        flash[:alert] = "Please sign in or create an account to proceed!"
        #TODO after use signed in, they're routed to root_path which is not ideal, would be good if they're routed to their previous path
        redirect_to new_user_session_path
      end 
    end 




end
