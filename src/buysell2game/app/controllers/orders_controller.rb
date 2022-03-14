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
        @order = Order.new(user_id: current_user.id, order_status: "pending")
        redirect_to root_path
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
