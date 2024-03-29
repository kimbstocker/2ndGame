class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # Below before action ensure unauthorised user cannot use URL to temper with the listing
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]

  def index

    # Filter the listings by category_id and user_id for shop by "Category" and "My listings" features.
    # This is possible because of the Foreign keys user_id and category_id attributes in the Listings table
    # The params[:id] (with the listing category names) is passed in from the link tags eg. "listings_category_path("puzzles")" in the view home.html.erb page and navbar.
    # Only listed listings are showed to users. Users wont see their own listing in buying page.
    # For those listing that have listing_status others than "listed" such as "draft", "sold" or "archived", only their owners can see those in their "my listings" page.

    if !user_signed_in?
      case params[:id]
      when "all"
        @listings = Listing.all.where(listing_status: "listed")
      when "family"
        @listings = Listing.where(category_id: 1, listing_status: "listed")
      when "strategy"
        @listings = Listing.where(category_id: 2, listing_status: "listed")
      when "classic"
        @listings = Listing.where(category_id: 3, listing_status: "listed")
      when "puzzles"
        @listings = Listing.where(category_id: 4, listing_status: "listed")
      when "fantasy"
        @listings = Listing.where(category_id: 5, listing_status: "listed")
      when "others"
        @listings = Listing.where(category_id: 6, listing_status: "listed")
      else
        render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      end
    else
      case params[:id]
      when "all"
        @listings = Listing.all.where(listing_status: "listed").where.not(user_id: current_user.id)
      when "family"
        @listings = Listing.where(category_id: 1, listing_status: "listed").where.not(user_id: current_user.id)
      when "strategy"
        @listings = Listing.where(category_id: 2, listing_status: "listed").where.not(user_id: current_user.id)
      when "classic"
        @listings = Listing.where(category_id: 3, listing_status: "listed").where.not(user_id: current_user.id)
      when "puzzles"
        @listings = Listing.where(category_id: 4, listing_status: "listed").where.not(user_id: current_user.id)
      when "fantasy"
        @listings = Listing.where(category_id: 5, listing_status: "listed").where.not(user_id: current_user.id)
      when "others"
        @listings = Listing.where(category_id: 6, listing_status: "listed").where.not(user_id: current_user.id)
      when "#{current_user.id}"
        @listings = current_user.listings
      when "favourites"
        user_favouties = User.find_by(id: current_user.id).favourites
        @listings = []
        user_favouties.each do |fav|
          @listings << fav.listing
        end
      else
        render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      end
    end
  end

  def show

    # Users can only view listed listings. If a listing is not at "listed" status, only the owner of the listing can view it
    if @listing.listing_status != "listed"
      if current_user.id != Listing.find(params[:id]).user_id
        flash[:alert] = "Unauthorised access"
        redirect_to root_path
      end
    end
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)

    update_listing_status

    if @listing.save
      redirect_to @listing, notice: "Listing successfully created"
    else
      set_form_vars
      render "new", notice: "An error has occurred, please try again"
    end
  end

  def edit
    #Only listing with status "draft" or "listed" can be edited
    if @listing.listing_status == "archived"
      flash[:alert] = "This listing details can no longer be changed"
    end

  end

  def update
    
    @listing.update(listing_params)
    
    update_listing_status

    if @listing.save
      redirect_to @listing, notice: "Listing successfully updated!"
    else
      set_form_vars
      render "edit", notice: "An error has occurred, please try again"
    end
  end

  def destroy
    if @listing.listing_status == "sold" || @listing.listing_status == "archived"
      flash[:alert] = "This listing can no longer be deleted as it has been sold or archived"
    else
      @listing.destroy
      redirect_to listings_category_path("#{@listing.user_id}"), notice: "Listing succesfully deleted"
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:listing_name, :price, :category_id, :condition, :description, :picture, :shipping)
  end

  #change listing status once the form is submitted
  def update_listing_status
    case params[:listing_status]
    when "Create Listing", "Update Listing"
      @listing.update(listing_status: 2)
    when "Save as draft"
      @listing.update(listing_status: 1)
    when "Attach receipt"
      @listing.update(listing_status: 4)
    end
  end

  def authorize_user
    if @listing.user_id != current_user.id
      flash[:alert] = "Unauthorised access"
      redirect_to root_path
    end
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def set_form_vars
    @categories = Category.all
    @conditions = Listing.conditions.keys
    @shipping_methods = Listing.shippings.keys
  end
end
