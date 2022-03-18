class CreateUsersFavourites < ActiveRecord::Migration[6.1]
  self.table_name :favourites
  def change
    create_table :users_favourites do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
