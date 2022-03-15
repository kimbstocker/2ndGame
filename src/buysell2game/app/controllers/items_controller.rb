class ItemsController < ApplicationController

    def index
    end

    def new
        @item = Item.new

    end

    def create

        @item = Item.new(listing_id: listing.id, order_id: @order.id, price: listing.price)

    end
end
