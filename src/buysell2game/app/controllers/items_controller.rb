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
        #Below code ensures after destroying one item, if the pending order is emptied, destroy it and send alert and reroute
        if order.items.empty?
            flash[:notice] = "Your cart is now emptied"
            order.destroy
            redirect_to root_path
        else
           redirect_to order_path("#{@item.order_id}"), notice: "Item succesfully removed"
        end
    end

end
