class ItemsController < ApplicationController

    def index
    end

    def new

    end

    def create


    end

    def destroy
        @item = Item.find_by(id: params[:item_id].to_i)
        @item.destroy
        order = Order.find_by(id: @item.order.id)
        #Below code ensures after destroying one item, if the order is empty, send alert and reroute to avoid error 
        if order.items.empty?
            flash[:alert] = "Your cart is empty"
            redirect_to root_path
        else
           redirect_to order_path("#{@item.order_id}"), notice: "Item succesfully removed"
        end
    end

end
