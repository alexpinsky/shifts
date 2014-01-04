class CreateEmployment < ActiveRecord::Migration
  def change
  	create_table :employments do |t|
      t.integer :workplace_id
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end
  end
end
