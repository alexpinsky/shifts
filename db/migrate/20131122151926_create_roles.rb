class CreateRoles < ActiveRecord::Migration
  def change
  	create_table :roles do |t|
      t.string  :name
      t.integer :work_place_id

      t.timestamps
    end
  end
end
