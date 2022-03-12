class AddDetailsToListings < ActiveRecord::Migration[6.1]
  def change

  change_column_null :listings, :listing_name, false
  change_column_null :listings, :condition, false
  change_column_null :listings, :price, false
  change_column_null :listings, :listing_status, false
  change_column_null :listings, :description, false
  change_column_null :listings, :shipping, false
    

  end
end
