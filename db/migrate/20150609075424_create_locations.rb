class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :locality
      t.string :region
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.string :postcode
      t.string :neighborhood
      t.string :country
      t.string :tel
      t.string :website
      t.string :hours_of_oper
      t.string :chain_name
      t.string :category_labels
      t.timestamps null: false
    end
  end
end



