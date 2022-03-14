class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.float :price
      t.boolean :sold, :default => false

      t.timestamps
    end
  end
end
