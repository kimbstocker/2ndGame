class ItemsController < ApplicationController

    def index
    end

    def new
        @item = Item.new

    end

    def create


    end

    def destroy
        @item = Item.find_by(id: params[:item_id].to_i)
        @item.destroy
        redirect_to order_path("#{@item.order_id}"), notice: "Item succesfully removed"

    end

end
