class Employment < ActiveRecord::Migration
  def change
  	create_table :employments do |t|
      t.integer :work_place_id
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end
  end
end
