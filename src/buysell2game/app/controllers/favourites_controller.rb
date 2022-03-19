class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fav

  def index
    redirect_to listings_category_path("favourites")
  end

  def create
    if @fav
      flash[:notice] = "Item has already been added!"
      redirect_back(fallback_location: root_path)
    else
      Favourite.create(user_id: current_user.id, listing_id: params[:listing_id])
      flash[:notice] = "Item succesfully added to your favourite list."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @fav.destroy
    flash[:notice] = "Item succesfully removed from your favourite list."
    redirect_back(fallback_location: root_path)
  end

  private

  def set_fav
    @fav = Favourite.find_by(listing_id: params[:listing_id], user_id: current_user.id)

  end

end
