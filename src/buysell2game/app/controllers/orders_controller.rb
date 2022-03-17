class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :sign_in_to_order
    before_action :authorize_user
    before_action :set_order, only: [:index, :show, :create]


    def index
      if !@order || @order.items.empty?
        flash[:notice] = "Your cart is empty!"
        redirect_back(fallback_location: root_path)
      else
        redirect_to order_path(@order.id)
      end

    end

    def show

      #Below is to ensure when all items are removed from Order, there wont be a Stripe error as the total below will be $0
      @items = @order.items.all
      
    end

    def new
        @order = Order.new
         
    end

    def create

      listing = Listing.find_by(id: params[:listing_id])
    # Only create a new line in Orders table if there isnt already one pending.
      if !@order
        @order = Order.create(user_id: current_user.id)
        @order_total_before_checkout = 0

      end
      #If the item is not already in the list of items under the order. create one
      if !@order.items.find_by(listing_id: listing.id)
        item = @order.items.create(listing_id: listing.id, price: listing.price)
        flash[:notice] = "Item succesfully added."
        @order_total_before_checkout += item.price
        @order.update(total: @order_total_before_checkout)

        redirect_back(fallback_location: root_path)
      #If already in the order, flash message and do not add
      else
        flash[:alert] = "Item already added."
        redirect_back(fallback_location: root_path)


      end




    end

    # def edit
    # end

    # def update
    # end

    def destroy
    end

  private

  def set_order
    @order = current_user.orders.find_by(order_status: "pending")
    if @order
      items = @order.items.all
      @order_total_before_checkout = 0
      items.each do |item| 
        @order_total_before_checkout += item.price
      end
    end

  end
  

  def sign_in_to_order 
    if !user_signed_in?
      flash[:alert] = "Please sign in or create an account to proceed!"
      #TODO after use signed in, they're routed to root_path which is not ideal, would be good if they're routed to their previous path
      redirect_to new_user_session_path
    end 
  end 


  def authorize_user 
    order = Order.find_by(id: params[:id])
    if order && order.user_id != current_user.id
      flash[:alert] = "Unauthorised access"
      redirect_to root_path

    end 
  end 




end
