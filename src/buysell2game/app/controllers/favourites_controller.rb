class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to listings_category_path("favourites")
  end

  def create
    Favourite.create(user_id: current_user.id, listing_id: params[:listing_id])
    flash[:notice] = "Item succesfully added to your favourite list."
    redirect_back(fallback_location: root_path)
  end

  def destroy
    fav = Favourite.find_by(listing_id: params[:listing_id], user_id: current_user.id)
    fav.destroy
    flash[:notice] = "Item succesfully removed from your favourite list."
    redirect_back(fallback_location: root_path)
  end

end
