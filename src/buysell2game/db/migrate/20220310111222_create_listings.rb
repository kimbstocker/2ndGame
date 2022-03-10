class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :listing_name
      t.integer :condition
      t.float :price
      t.integer :listing_status
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :shipping

      t.timestamps
    end
  end
end
