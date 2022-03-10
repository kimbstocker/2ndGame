class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :listing_name, null: false
      t.integer :condition, null: false
      t.float :price, null: false
      t.integer :listing_status
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :shipping

      t.timestamps
    end
  end
end
