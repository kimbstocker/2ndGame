class ItemsController < ApplicationController
  before_action :authenticate_user!
  # Authorise user is checked in the destroy method

  def index
  end

  def new
  end

  def create
  end

  def destroy
    @item = Item.find_by(id: params[:item_id].to_i)
    if @item.order.user.id == current_user.id 
      @item.destroy
      order = Order.find_by(id: @item.order.id)
      #Below code ensures after destroying one item, if the pending order is emptied, destroy it and send alert and reroute
      if order.items.empty?
        flash[:notice] = "Your cart is now emptied"
        order.destroy
        redirect_to root_path
      else
        redirect_to order_path("#{@item.order_id}"), notice: "Item succesfully removed"
      end
    else
      flash[:alert] = "Unauthorised access"
      redirect_to root_path
    end
  end


end
