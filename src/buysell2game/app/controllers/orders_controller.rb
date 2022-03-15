class OrdersController < ApplicationController
    # before_action :authorize_user, only: [:create, :show, :destroy]

    def index
    end

    def show
    end

    def new
        @order = Order.new
         
    end

    def create

      #Order status attribute has a problem. Did not update. CHECK
      
      if !current_user.orders.find_by(order_status: "pending")
        @order = Order.new(user_id: current_user.id)
      else
        @order = current_user.orders.find_by(order_status: "pending")
      end

      listing = Listing.find_by(id: params[:listing_id].to_i)
      @item = @order.items.new(listing_id: listing.id, price: listing.price)

      # TODO redirect or something
    end

    def edit
    end

    def update
    end

    def destroy
    end

private

    # def authorize_user 
    #   if !user_signed_in?
    #     flash[:alert] = "Please sign in or create an account first"
    #     redirect_to root_path
    #   end 
    # end 




end
