class ListingsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]



  def index

    # Filter the listings by category for "shop by category" function. 
    # The params[:id] (with the listing category names) is passed in from the link tags eg. "listings_path("puzzles")" in the view home.html.erb page and navbar.

    case params[:id]
    when "all"
      @listings = Listing.all
    when "family"
      @listings = Listing.where(category_id: 1)
    when "strategy"
      @listings = Listing.where(category_id: 2)
    when "classic"
      @listings = Listing.where(category_id: 3)
    when "puzzles"
      @listings = Listing.where(category_id: 4)
    when "fantasy"
      @listings = Listing.where(category_id: 5)
    when "others"
      @listings = Listing.where(category_id: 6)
    when "#{current_user.id}"
      @listings = current_user.listings
    end

  end

  def show


  end


  private
    def listing_params
      params.require(:listing).permit(:title, :price, :category_id, :condition, :description, :picture)
    end

    def set_listing
      @listing = Listing.find(params[:id])
    end

end
