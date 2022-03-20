class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :set_order, only: [:index, :show, :create]

  def index
    if current_user.orders.empty?
      flash[:alert] = "You have no order yet!"
      redirect_back(fallback_location: root_path)
    else
      @orders = current_user.orders.where.not(order_status: "pending")
    end
  end

  def show
    if !@order || @order.items.empty?
      flash[:notice] = "Your cart is empty!"
      redirect_to root_path
    else
      @items = @order.items.all.eager_load(:listing)
    end
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
    #Add the item price to the order total (before checkout) and update it
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
    #Record the order total before checkout
    if @order
      items = @order.items.all
      @order_total_before_checkout = 0
      items.each do |item|
        @order_total_before_checkout += item.price
      end
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
