class OrdersController < ApplicationController
    # before_action :authorize_user, only: [:create, :show, :destroy]
    before_action :set_order, only: [:edit, :update, :destroy]


    def index
    end

    def show

        pending_order = current_user.orders.find_by(order_status: "pending")
        if pending_order.items != nil
            @items = pending_order.items.all
        else
            flash[:alert] = "Your cart is empty"
            redirect_to root_path
        end
            

        # Users can only view listed listings. If a listing is not at "listed" status, only the owner of the listing can view it
        # if @listing.listing_status != "listed"
        #   if !current_user || current_user.id != Listing.find(params[:id]).user_id
        #     flash[:alert] = "Unauthorised access"
        #     redirect_to root_path
        #   end        
         
        # end
    end

    def new
        @order = Order.new
         
    end

    def create

    # Only create a new line in Orders table if there isnt already one pending.
      if !current_user.orders.find_by(order_status: "pending")
        @order = Order.create(user_id: current_user.id)
      else
        @order = current_user.orders.find_by(order_status: "pending")
      end

      listing = Listing.find_by(id: params[:listing_id].to_i)
      if !@order.items.find_by(listing_id: listing.id)
        @item = @order.items.create(listing_id: listing.id, price: listing.price)
      else
        @item = @order.items.find_by(listing_id: listing.id)
      end

      # TODO redirect or something
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
    

    # def authorize_user 
    #   if !user_signed_in?
    #     flash[:alert] = "Please sign in or create an account first"
    #     redirect_to root_path
    #   end 
    # end 




end
