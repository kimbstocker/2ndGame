class FavouritesController < ApplicationController
    before_action :authenticate_user!

    def index
      
    end

    def create

        Favourite.create(user_id: current_user.id, listing_id: params[:listing_id])
        flash[:notice] = "Item succesfully added to your favourite list."


    end

    def destroy

        fav = Favourite.find_by(listing_id: params[:listing_id], user_id: current_user.id)
        fav.destroy
        flash[:notice] = "Item succesfully deleted from your favourite list."
        redirect_back(fallback_location: root_path)

    end

    private

    def authorize_user 
        # order = Order.find_by(id: params[:id])
        # if order && order.user_id != current_user.id
        #     flash[:alert] = "Unauthorised access"
        #     redirect_to root_path

        # end 
    end 

end
