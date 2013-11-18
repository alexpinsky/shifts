class CreateLocations < ActiveRecord::Migration
  def change
  	create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :locationable_id
      t.string  :locationable_type

      t.timestamps
    end
  end
end
